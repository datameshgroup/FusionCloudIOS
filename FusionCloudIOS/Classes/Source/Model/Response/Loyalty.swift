//
//  Loyalty.swift
//  FusionCloud
//
//  Created by Vanessa on 12/4/2023.
//

import Foundation
import ObjectMapper

public class LoyaltyResult: Mappable {
    
    public var loyaltyAccount: LoyaltyAccount?
    public var currentBalance: NSDecimalNumber?
    public var loyaltyAmount: LoyaltyAmount?
    public var loyaltyAcquirerData: LoyaltyAcquirerData?
    public var rebates: Rebates?
    
    public required init?(map: Map) {}
    
    public func mapping(map: Map) {
        loyaltyAccount      <- map["LoyaltyAccount"]
        currentBalance      <- (map["CurrentBalance"], NSDecimalNumberTransform())
        loyaltyAmount       <- map["LoyaltyAmount"]
        loyaltyAcquirerData <- map["LoyaltyAcquirerData"]
        rebates             <- map["Rebates"]
    }
    
    
}

public class LoyaltyAccount: Mappable {
    
    public var loyaltyAccountID: LoyaltyAccountID?
    public var loyaltyBrand: LoyaltyBrand?
    
    public required init?(map: Map) {}
    
    public func mapping(map: Map) {
        loyaltyAccountID    <- map["LoyaltyAccountID"]
        loyaltyBrand        <- map["LoyaltyBrand"]
    }
    
    
}

public class LoyaltyAccountID: Mappable {
    
    public var entryMode: EntryMode?
    public var identificationType: IdentificationType?
    public var identificationSupport: IdentificationSupport?
    public var loyaltyID: String?
    
    public required init?(map: Map) {}
    public func mapping(map: Map) {
        entryMode               <- map["EntryMode"]
        identificationType      <- map["IdentificationType"]
        identificationSupport   <- map["IdentificationSupport"]
        loyaltyID               <- map["LoyaltyID"]
    }
    
    
}
public class LoyaltyAmount: Mappable {
    
    public var loyaltyUnit: LoyaltyUnit?
    public var currency: CurrencySymbol?
    public var amountValue: NSDecimalNumber?
    
    public required init?(map: Map) {}
    public func mapping(map: Map) {
        loyaltyUnit <- map["LoyaltyUnit"]
        currency    <- map["Currency"]
        amountValue <- (map["AmountValue"], NSDecimalNumberTransform())
    }
    
    
}

public class LoyaltyAcquirerData: Mappable {
    
    public var loyaltyAcquirerID: String?
    public var approvalCode: String?
    public var loyaltyTransactionID: LoyaltyTransactionID?
    public var hostReconciliationID: String?
    
    public required init?(map: Map) {}
    
    public func mapping(map: Map) {
        loyaltyAcquirerID       <- map["LoyaltyAcquirerID"]
        approvalCode            <- map["ApprovalCode"]
        loyaltyTransactionID    <- map["LoyaltyTransactionID"]
        hostReconciliationID    <- map["HostReconciliationID"]
    }
    
}

public class LoyaltyTransactionID: Mappable {
    
    public var transactionID: String?
    public var timeStamp: Date?
    
    public required init?(map: Map) {}
    public func mapping(map: Map) {
        transactionID   <- map["TransactionID"]
        timeStamp       <- (map["TimeStamp"], ISO8601DateTransform())
    }
    
    
}

