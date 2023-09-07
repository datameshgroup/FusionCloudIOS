//
//  FusionClient.swift
//  FusionCloud
//
//  Created by Clinton on 23/8/2022.
//

import Foundation
import Starscream
import ObjectMapper


public protocol FusionClientDelegate: AnyObject {
    //Socket events
    func socketConnected(client: FusionClient)
    func socketDisconnected(client: FusionClient)
    func socketReceived(client: FusionClient, data: String)
    func socketError(client: FusionClient, error: Error)
    
    func logData(client: FusionClient,type: String, data: String) //logtype: info, error, warning
    
    func loginResponseReceived(client: FusionClient, messageHeader: MessageHeader, loginResponse: LoginResponse)
    func paymentResponseReceived(client: FusionClient, messageHeader: MessageHeader, paymentResponse: PaymentResponse)
    func transactionStatusResponseReceived(client: FusionClient, messageHeader: MessageHeader, transactionStatusResponse: TransactionStatusResponse)
    
    func displayRequestReceived(client: FusionClient, messageHeader: MessageHeader, displayRequest: DisplayRequest)
    func eventNotificationReceived(client: FusionClient, messageHeader: MessageHeader, eventNotification: EventNotification)
    
    func reconcilationResponseReceived(client: FusionClient, messageHeader: MessageHeader, reconcilationResponse: ReconciliationResponse)
    func cardAcquisitionResponseReceived(client: FusionClient, messageHeader: MessageHeader, cardAcquisitionResponse: CardAcquisitionResponse)
    func logoutResponseResponseReceived(client: FusionClient, messageHeader: MessageHeader, logoutResponse: LogoutResponse)
    func credentialsError(client: FusionClient,error: String)
}

@available(iOS 12.0, *)
public class FusionClient: WebSocketDelegate{
    public func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(_):
            fusionClientDelegate?.socketConnected(client: self)
        case .disconnected(_, _):
            fusionClientDelegate?.socketDisconnected(client: self)
            //reconnect?
        case .text(let string):
            fusionClientDelegate?.socketReceived(client: self, data: string)
            parseResponse(str: string)
        case .binary(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            fusionClientDelegate?.socketDisconnected(client: self)
        case .error(let error):
            if let e = error as? WSError {
                appendLog(type: "error",  content: "websocket encountered an WS-error: \(e.message)")
            }
            else if let e = error {
                appendLog(type: "error", content: "websocket encountered an error: \(e.localizedDescription)")
            }
            else {
                appendLog(type: "error", content: "websocket encountered an unknown error")
            }
            fusionClientDelegate?.socketError(client: self, error: error!)
        case .pong(_):
            break;
        case .ping(_):
            break;
        }
    }
    

    
    func parseResponse(str: String){
        appendLog(type: "info", content: "RX: \(str)")
        
        let rc = SaleToPOI(JSONString: str)
        do{
            // validate security trailer
            try crypto.validateSecurityTrailer(securityTrailer: (rc!.saleToPOIResponse?.securityTrailer ?? rc!.saleToPOIRequest?.securityTrailer)!, kek: fusionCloudConfig!.kekValue!, raw: str)


            // Message will be in saleToPOIRequest (for displays) or saleToPOIResponse (for all others)
            let poiResp = rc?.saleToPOIResponse
            let poiRequ = rc?.saleToPOIRequest
            let mh = poiResp?.messageheader ?? poiRequ?.messageHeader
            
            // Validate response
            if ((poiRequ == nil && poiResp == nil) || mh == nil ||
                mh?.messageCategory == nil) {
                appendLog(type: "error", content: "Invalid response. Data == nil") //logtype: error
                return
            }
            
            switch(mh!.messageCategory)
            {
            case .Login:
                let r = poiResp?.loginResponse;
                if(r == nil) {
                    appendLog(type: "error", content: "Invalid \(String(describing: mh!.messageCategory)) response. Payload == nil")
                    return
                }
                fusionClientDelegate?.loginResponseReceived(client: self, messageHeader: mh!, loginResponse: r!)
                break
            case .Payment:
                    let r = poiResp?.paymentResponse;
                    if(r == nil) {
                        appendLog(type: "error", content: "Invalid \(String(describing: mh!.messageCategory)) response. Payload == nil")
                        return
                    }
                fusionClientDelegate?.paymentResponseReceived(client: self, messageHeader: mh!, paymentResponse: r!)
                break
            case .TransactionStatus:
                let r = poiResp?.transactionStatusResponse;
                if(r == nil) {
                    appendLog(type: "error", content: "Invalid \(String(describing: mh!.messageCategory)) response. Payload == nil")
                    return
                }
                fusionClientDelegate?.transactionStatusResponseReceived(client: self, messageHeader: mh!, transactionStatusResponse: r!)
                break
            case .Display:
                let r = poiRequ?.displayRequest;
                if(r == nil) {
                    appendLog(type: "error", content: "Invalid \(String(describing: mh!.messageCategory)) response. Payload == nil")
                    return
                }
                fusionClientDelegate?.displayRequestReceived(client: self, messageHeader: mh!, displayRequest: r!)
                break
            case .Reconciliation:
                let r = poiResp?.reconciliationResponse;
                if(r == nil) {
                    appendLog(type: "error", content: "Invalid \(String(describing: mh!.messageCategory)) response. Payload == nil")
                    return
                }
                fusionClientDelegate?.reconcilationResponseReceived(client: self, messageHeader: mh!, reconcilationResponse: r!)
                break
            case .CardAcquisition:
                let r = poiResp?.cardAcquisitionResponse;
                if(r == nil) {
                    appendLog(type: "error", content: "Invalid \(String(describing: mh!.messageCategory)) response. Payload == nil")
                    return
                }
                fusionClientDelegate?.cardAcquisitionResponseReceived(client: self, messageHeader: mh!, cardAcquisitionResponse: r!)
                break
            case .Logout:
                let r = poiResp?.logoutResponse;
                if(r == nil) {
                    appendLog(type: "error", content: "Invalid \(String(describing: mh!.messageCategory)) response. Payload == nil")
                    return
                }
                fusionClientDelegate?.logoutResponseResponseReceived(client: self, messageHeader: mh!, logoutResponse: r!)
                break
            case .Event:
                let r = poiRequ?.eventNotification ?? poiResp?.eventNotification
                if(r == nil) {
                    appendLog(type: "error", content: "Invalid \(String(describing: mh!.messageCategory)) response. Payload == nil")
                    return
                }
                fusionClientDelegate?.eventNotificationReceived(client: self, messageHeader: mh!, eventNotification: r!)
                break
            default:
                appendLog(type: "info", content: "Unknown message type: " + mh!.messageCategory!.rawValue)
            }
        }
        catch is MacValidation {
            appendLog(type: "warning", content: "Received and ignored a response with invalid MAC")
        }
        catch {
            appendLog(type: "warning", content: "Ignored a response with parsing error")
        }

    }
    
    public var fusionCloudConfig: FusionCloudConfig?
    public var socket: WebSocket?
    public var messageHeader: MessageHeader?
    public var securityTrailer: SecurityTrailer?
    public weak var fusionClientDelegate: FusionClientDelegate?
    
    let crypto = Crypto()

    public init(){
    }
    
    public init(fusionCloudConfig: FusionCloudConfig){
        self.fusionCloudConfig = fusionCloudConfig
        let request = URLRequest(url: URL(string: fusionCloudConfig.serverDomain!)!)
        let pinner = FoundationSecurity(allowSelfSigned: fusionCloudConfig.allowSelfSigned ?? true) // don't validate SSL certificates FOR NOW
        self.socket = WebSocket(request: request, certPinner: pinner)
        socket!.delegate = self
        socket!.connect()
        
        
        createDefaultHeader()
        createDefaultSecurityTrailer()

    }

      // Creates a default MessageHeader based on the configured saleId and poiId
      public func createDefaultHeader() {
          messageHeader = MessageHeader()
          messageHeader!.protocolVersion = "3.1-dmg"
          messageHeader!.messageClass = .Service
          messageHeader!.messageType = .Request
          messageHeader!.saleID = fusionCloudConfig!.saleID
          messageHeader!.poiID = fusionCloudConfig!.poiID
      }
      
      // Creates a default MessageHeader based on the configured KEK
      public func createDefaultSecurityTrailer() {
          securityTrailer = SecurityTrailer()
          securityTrailer!.contentType = "id-ct-authData"
          
          let authenticatedData = AuthenticationData()
              authenticatedData.version = "v0"
              let recipient = Recipient()
                  let KEK = KEK()
                      KEK.version = "v4"
                          
                      //inside kek
                      let kekIdentifier = KEKIdentifier()
                          kekIdentifier.keyIdentifier = fusionCloudConfig!.keyIdentifier!
                          kekIdentifier.keyVersion = fusionCloudConfig!.keyVersion!
                      
                      let keyEncryptionAlgorithm = KeyEncryptionAlgorithm()
                          keyEncryptionAlgorithm.algorithm = "des-ede3-cbc"
          
                      KEK.kekIdentifier = kekIdentifier
                      KEK.kekAlgorithm = keyEncryptionAlgorithm
                      KEK.encryptedKey = ""//encryptedString
                      
                  //inside receipient
                  let macAlgorithm = MACAlgorithm()
                      macAlgorithm.algorithm = "id-retail-cbc-mac-sha-256"
                  
                  let encapsulatedContent = EncapsulatedContent()
                      encapsulatedContent.contentType = "id-data"
          
              recipient.kek = KEK
              recipient.macAlgorithm = macAlgorithm
              recipient.encapContent = encapsulatedContent
              recipient.mac = ""//MAC
          
          authenticatedData.recipient = recipient
          securityTrailer!.authenticationData = authenticatedData
      }

    public func sendMessage<T: Mappable>(requestBody: T, type: String){
        let mh = self.messageHeader!.toJSONString()

        if mh!.contains("Login") {
            let k = fusionCloudConfig!.kekValue!
            if k.count != 48{
                appendLog(type: "error", content: "Invalid KEK Value")
                fusionClientDelegate?.credentialsError(client: self, error: "Invalid KEK Value")
                return
            }
            var g = k.unicodeScalars.makeIterator()
            var a : [UInt8] = []
            while let msn = g.next()
            {
                if let lsn = g.next()
                {
                    a += [ (convertHexDigit(c:msn) << 4 | convertHexDigit(c:lsn)) ]
                }
                else
                {
                    appendLog(type: "error", content: "Invalid KEK Value")
                    fusionClientDelegate?.credentialsError(client: self, error: "Invalid KEK Value")
                    return
                }
            }
        }
    
        let request = crypto.buildRequest(kek: fusionCloudConfig!.kekValue!, request: requestBody, header: self.messageHeader!, security: self.securityTrailer!, type: type)

        appendLog(type: "info", content: "TX: \(request)")
        socket!.write(data: request.data(using: .utf8)!, completion: {})
    }
    func appendLog(type: String, content: String) {
        ///types: error, warning, info
        fusionClientDelegate?.logData(client: self, type: type, data: content)
    }
    func convertHexDigit(c : UnicodeScalar) -> UInt8
    {
        switch c {
            case UnicodeScalar("0")...UnicodeScalar("9"): return UInt8(c.value - UnicodeScalar("0").value)
            case UnicodeScalar("a")...UnicodeScalar("f"): return UInt8(c.value - UnicodeScalar("a").value + UInt32(0xa))
            case UnicodeScalar("A")...UnicodeScalar("F"): return UInt8(c.value - UnicodeScalar("A").value + UInt32(0xa))
            default: appendLog(type: "error", content: "convertHexDigit: Invalid hex digit")
                        return UInt8(0)
        }
    }
    
}
