//
//  LoginRequest.swift
//  TestApplication
//
//  Created by loey on 2/6/22.
//  Copyright © 2022 loey. All rights reserved.
//

import Foundation
import ObjectMapper

public class LoginRequest: Mappable {
    
    public var dateTime: Date?
    public var saleSoftware : SaleSoftware?
    public var saleTerminalData : SaleTerminalData?
    public var trainingModeFlag: Bool?
    public var operatorLanguage: String?
    public var operatorID: String?
    public var shiftNumber: String?
    public var pOISerialNumber: String?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        dateTime            <- (map["DateTime"], ISO8601DateTransform())
        saleSoftware        <- map["SaleSoftware"]
        saleTerminalData    <- map["SaleTerminalData"]
        trainingModeFlag    <- map["TrainingModeFlag"]
        operatorLanguage    <- map["OperatorLanguage"]
        operatorID          <- map["OperatorID"]
        shiftNumber         <- map["ShiftNumber"]
        pOISerialNumber     <- map["POISerialNumber"]
    }
    
}


public class SaleSoftware: Mappable {
    
    public var providerIdentification: String?
    public var applicationName: String?
    public var softwareVersion: String?
    public var certificationCode: String?
    public var componentType: String?
    
    public required init(){}
    public required init?(map: Map) {}
       public func mapping(map: Map) {
           providerIdentification   <- map["ProviderIdentification"]
           applicationName          <- map["ApplicationName"]
           softwareVersion          <- map["SoftwareVersion"]
           certificationCode        <- map["CertificationCode"]
           componentType            <- map["ComponentType"]
       }
}

public class SaleTerminalData: Mappable {
    
    /// Attended, SemiAttended, Unattended
    public var terminalEnvironment: TerminalEnvironment?
    
    /// CashierStatus, CashierError, CashierInput, CustomerAssistance, PrinterReceipt,
    public var saleCapabilities: [SaleCapability]?
    public var saleProfile: SaleProfile?
    public var totalsGroupID: String?
    
    public required init(){}
     public required init?(map: Map) {}
     public func mapping(map: Map) {
        terminalEnvironment     <- map["TerminalEnvironment"]
        saleCapabilities        <- map["SaleCapabilities"]
        saleProfile             <- map["SaleProfile"]
        totalsGroupID           <- map["TotalsGroupID"]
     }
}

public class SaleProfile: Mappable {
    
    /// Basic, Standard, Extended, Custom
    public var genericProfile: String?
    
    /// Synchro, Standard, OneTimeRes, Reservation, Loyalty, StoredValue, PIN, CardReader, Sound, Communication
    public var serviceProfiles: [String]?
    
    public required init(){}
      public required init?(map: Map) {}
      public func mapping(map: Map) {
         genericProfile <- map["GenericProfile"]
         serviceProfiles <- map["ServiceProfiles"]
      }
}
