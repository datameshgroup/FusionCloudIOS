//
//  LoginResponse.swift
//  TestAppDM
//
//  Created by Loey Agdan on 4/15/22.
//

import Foundation
import ObjectMapper


public class LoginResponse: Mappable, ResponseType{
    
    public var response: Response?
    public var poiSystemData: POISystemData?
    
    public func mapping(map: Map) {
        response        <-  map["Response"]
        poiSystemData   <-  map["POISystemData"]
    }
    
    
    public required init?(map: Map) {}
    public required init(){}
}

public class POISystemData : Mappable {
    
    public var dateTime: String?
    public var poiSoftware: POISoftware?
    public var poiTerminalData: POITerminalData?
    public var poiStatus: POIStatus?
    public var tokenRequestStatus: Bool?
    
    public func mapping(map: Map) {
        dateTime            <-  map["DateTime"]
        poiSoftware         <-  map["POISoftware"]
        poiTerminalData     <-  map["POITerminalData"]
        poiStatus           <-  map["POIStatus"]
        tokenRequestStatus  <-  map["TokenRequestStatus"]
    }
    
    public required init?(map: Map) {}
    public required init(){}
}

public class POISoftware : Mappable {
    var providerIdentification: String?
    var applicationName: String?
    var softwareVersion: String?
    
    public func mapping(map: Map) {
    providerIdentification <- map["ProviderIdentification"]
    applicationName <- map["ApplicationName"]
    softwareVersion <- map["SoftwareVersion"]
    }
    
    public required init?(map: Map) {}
    public required init(){}
    
}

    public class POITerminalData : Mappable {
        
        var terminalEnvironment: TerminalEnvironment?
        var poiCapabilities: [POICapability]?
        var poiProfile: POIProfile?
        var poiSerialNumber: String?
        
        public func mapping(map: Map) {
            terminalEnvironment     <-  map["TerminalEnvironment"]
            poiCapabilities         <-  map["POICapabilities"]
            poiProfile              <-  map["POIProfile"]
            poiSerialNumber         <-  map["POISerialNumber"]
        }
        
        public required init?(map: Map) {}
        public required init(){}
    }

        public class POIProfile : Mappable {
            
            public var genericProfile: String?
            
            public func mapping(map: Map) {
                genericProfile    <-  map["GenericProfile"]
            }
            
            public required init?(map: Map) {}
            public required init(){}
        }

public class POIStatus : Mappable {
    
    public var globalStatus: String?
    public var pedOkFlag: Bool?
    public var securityOkFlag: Bool?
    public var cardReaderOkFlag: Bool?
    public var printerStatus: String?
    public var communicationOKFlag: Bool?
    public var fraudPreventionFlag: Bool?
    
    public func mapping(map: Map) {
        globalStatus        <-  map["GlobalStatus"]
        pedOkFlag           <-  map["PEDOKFlag"]
        securityOkFlag      <-  map["SecurityOKFlag"]
        cardReaderOkFlag    <-  map["CardReaderOKFlag"]
        printerStatus       <-  map["PrinterStatus"]
        communicationOKFlag <-  map["CommunicationOKFlag"]
        fraudPreventionFlag <-  map["FraudPreventionFlag"]
    }
    
    public required init?(map: Map) {}
    public required init(){}
}



