//
//  QRController.swift
//  FusionCloudIOS_Example
//
//  Created by Vanessa on 12/9/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import FusionCloudIOS
import CoreImage.CIFilterBuiltins
let context = CIContext()
let filter = CIFilter.qrCodeGenerator()
var errorDescription = ""

class QRController: UIViewController, FusionClientDelegate{
 
    var receivedPOIID: String?
    //SaleID, unique to the POS instance. Autogenerate this once per POS instance.
    var s:String = UUID().uuidString;
    //PairingPOIID. This will be populated on the pairing response
    var p:String = ""
    //KEK. Autogenerate this once per POS instance.
    var k:String = PairingData.createKEK();
    var currentServiceID = ""
    
    //TODO check serviceID of response
    func socketConnected(client: FusionCloudIOS.FusionClient) {
        print("socketConnected")
        connectionSuccessful()
    }
    
    func socketDisconnected(client: FusionCloudIOS.FusionClient) {
        print("socketDisconnected")
        connectionFailure(errorMessage: "socketDisconnected")
    }
    
    func socketReceived(client: FusionCloudIOS.FusionClient, data: String) {
        print("socketReceived")
    }
    
    func socketError(client: FusionCloudIOS.FusionClient, error: Error) {
        print("socketError")
        connectionFailure(errorMessage: error.localizedDescription)
    }
    
    func logData(client: FusionCloudIOS.FusionClient, type: String, data: String) {
        print("logData")
        print(data)
    }
    
    func loginResponseReceived(client: FusionCloudIOS.FusionClient, messageHeader: FusionCloudIOS.MessageHeader, loginResponse: FusionCloudIOS.LoginResponse) {
        print("loginResponseReceived")
        print(loginResponse)
        if (loginResponse.response?.result == ResponseResult.Success) {
            receivedPOIID = messageHeader.poiID
            loginSuccessful()
        }
        else{
            loginFailure(errorMessage: "Login Failure. " + (loginResponse.response?.additionalResponse ?? "unknown error"))
        }
        
    }
    
    func paymentResponseReceived(client: FusionCloudIOS.FusionClient, messageHeader: FusionCloudIOS.MessageHeader, paymentResponse: FusionCloudIOS.PaymentResponse) {
        print("paymentResponseReceived")
    }
    
    func transactionStatusResponseReceived(client: FusionCloudIOS.FusionClient, messageHeader: FusionCloudIOS.MessageHeader, transactionStatusResponse: FusionCloudIOS.TransactionStatusResponse) {
        print("transactionStatusResponseReceived")
    }
    
    func displayRequestReceived(client: FusionCloudIOS.FusionClient, messageHeader: FusionCloudIOS.MessageHeader, displayRequest: FusionCloudIOS.DisplayRequest) {
        print("displayRequestReceived")
    }
    
    func eventNotificationReceived(client: FusionCloudIOS.FusionClient, messageHeader: FusionCloudIOS.MessageHeader, eventNotification: FusionCloudIOS.EventNotification) {
        print("eventNotificationReceived")
    }
    
    func reconcilationResponseReceived(client: FusionCloudIOS.FusionClient, messageHeader: FusionCloudIOS.MessageHeader, reconcilationResponse: FusionCloudIOS.ReconciliationResponse) {
        print("reconcilationResponseReceived")
    }
    
    func cardAcquisitionResponseReceived(client: FusionCloudIOS.FusionClient, messageHeader: FusionCloudIOS.MessageHeader, cardAcquisitionResponse: FusionCloudIOS.CardAcquisitionResponse) {
        print("cardAcquisitionResponseReceived")
    }
    
    func logoutResponseResponseReceived(client: FusionCloudIOS.FusionClient, messageHeader: FusionCloudIOS.MessageHeader, logoutResponse: FusionCloudIOS.LogoutResponse) {
        print("logoutResponseResponseReceived")
    }
    
    func credentialsError(client: FusionCloudIOS.FusionClient, error: String) {
        print("credentialsError")
        loginFailure(errorMessage: error)
    }

    @IBOutlet weak var imageQRCode: UIImageView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var txtPairingInstructions: UITextView!
    @IBOutlet weak var btnManual: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var indicatorLoading: UIActivityIndicatorView!
    @IBOutlet weak var txtStatus: UILabel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        print("Generated KEK:" + k)
        print("Generated UUD:" + s)
        
        indicatorLoading.isHidden = true
        txtStatus.isHidden = true
        
        generateQRCode()
    }
    
    func generateQRCode() {
        print("Generating QR Code...")
        
        p = UUID().uuidString //PairingPOIID
        let c = fusionCloudConfig.certificationCode //CertificationCode
        let n = "IOS Demo App v1.0A" //POS display name with at most 30 characters.
        
        let newPairingData = fusionClient.createPairingData(
                                       saleID: s,
                                       pairingPOIID: p,
                                       kek: k,
                                       posName: n,
                                       certificationCode: c)
        print(newPairingData?.toJSONString()! ?? "default value")
        let qrCodeValue = genQRCode(from: newPairingData?.toJSONString()! ?? "default value")

        imageQRCode.image = qrCodeValue
        imageQRCode.layer.magnificationFilter = kCAFilterNearest

        
        
    }
    
    func genQRCode(from input: String) -> UIImage? {

        let data = Data(input.utf8)
        filter.setValue(data, forKey: "inputMessage")
        if let qrCodeImage = filter.outputImage {
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                return UIImage(cgImage: qrCodeCGImage)
            }
        }
        return UIImage(systemName: "xmark") ?? UIImage()
    }
    
    
    @IBAction func btnNext(_ sender: Any) {
        
        indicatorLoading.isHidden = false
        
        
        UserDefaults.standard.initFusion()
        fusionClient.fusionClientDelegate = self
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnManual(_ sender: Any) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "ManualSettingStoryboard")
        DispatchQueue.main.async { [weak self] in
            self?.present(vc, animated: true, completion: nil)
        }
    }
    
    func connectionSuccessful(){
        indicatorLoading.isHidden=true
        txtStatus.isHidden = false
        txtStatus.text = "Socket Connected. Logging in..."
        txtStatus.textColor = UIColor.systemGreen
        
        //TODO Validate required input
        
        doLogin()
    }
    
    func doLogin(){
        self.currentServiceID = UUID().uuidString
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
            
        fusionClient.messageHeader?.serviceID = currentServiceID
        fusionClient.messageHeader?.messageCategory = MessageCategory.Login
        fusionClient.messageHeader?.saleID = s //Set MessageHeader.SaleID to the pairing QR code SaleID value
        fusionClient.messageHeader?.poiID = p //Only for this specific request, set MessageHeader.POIID to the pairing QR code PairingPOIID value
        fusionCloudConfig.kekValue = k
        
                
        let loginRequest = LoginRequest()
            loginRequest.dateTime = Date()
            loginRequest.operatorLanguage = "en"
            loginRequest.pairing = true         //New for QR Pairing
            
        let saleSoftware = SaleSoftware()
            saleSoftware.providerIdentification = fusionCloudConfig.providerIdentification
            saleSoftware.applicationName = fusionCloudConfig.applicationName
            saleSoftware.softwareVersion = fusionCloudConfig.softwareVersion
            saleSoftware.certificationCode = fusionCloudConfig.certificationCode
                
        let saleTerminalData = SaleTerminalData()
        saleTerminalData.terminalEnvironment = TerminalEnvironment.Attended
        saleTerminalData.saleCapabilities = [SaleCapability.CashierStatus, SaleCapability.CashierError, SaleCapability.CashierInput, SaleCapability.CustomerAssistance, SaleCapability.PrinterReceipt]
                
        loginRequest.saleTerminalData = saleTerminalData
        loginRequest.saleSoftware = saleSoftware
        fusionClient.sendMessage(requestBody: loginRequest, type: "LoginRequest")
        
    }
    

    func connectionFailure(errorMessage: String){
        indicatorLoading.isHidden=true
        txtStatus.isHidden = false
        txtStatus.text = "Socket Connection Failed. \nDetail: " + errorMessage
        txtStatus.textColor = UIColor.systemRed
        errorDescription = txtStatus.text!
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "NotPairedStoryboard")
            DispatchQueue.main.async { [weak self] in
                self?.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    func loginFailure(errorMessage: String){
        indicatorLoading.isHidden=true
        txtStatus.isHidden = false
        txtStatus.text = "Login Failed. Detail: " + errorMessage
        txtStatus.textColor = UIColor.systemRed
        
        errorDescription = txtStatus.text!
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "NotPairedStoryboard")
            DispatchQueue.main.async { [weak self] in
                self?.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    func loginSuccessful(){
        indicatorLoading.isHidden=true
        txtStatus.isHidden = false
        txtStatus.text = "Login Successful. Saving.."
        txtStatus.textColor = UIColor.systemGreen
        
        saveConfig()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            self.dismiss(animated: true, completion: nil)
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "PairedStoryboard")
            DispatchQueue.main.async { [weak self] in
                self?.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    func saveConfig(){
        UserDefaults.standard.setSaleID(value: s)
        UserDefaults.standard.setPOIID(value: receivedPOIID!)
        UserDefaults.standard.setKEK(value: k)
        
        UserDefaults.standard.setPaired(value: true)
    }
}
