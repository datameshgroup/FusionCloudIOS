//
//  Rebates.swift
//  FusionCloud
//
//  Created by Vanessa on 12/4/2023.
//

import Foundation
import ObjectMapper

public class Rebates: Mappable {
    
    public var totalRebate: NSDecimalNumber?
    public var rebateLabel: String?
    public var saleItemRebate: [SaleItemRebate]?
    
    
    public required init?(map: Map) {}
    
    public func mapping(map: Map) {
        totalRebate     <- (map["TotalRebate"], NSDecimalNumberTransform())
        rebateLabel     <- map["RebateLabel"]
        saleItemRebate  <- map["SaleItemRebate"]
    }
}

public class SaleItemRebate: Mappable {
    
    public var itemID: Int64?
    public var productCode: String?
    public var eanUpc: String?
    public var unitOfMeasure: String?
    public var quantity: NSDecimalNumber?
    public var itemAmount: NSDecimalNumber?
    public var rebateLabel: String?
    
    
    public required init?(map: Map) {}
    
    public func mapping(map: Map) {
        itemID                  <- map["ItemID"]
        productCode             <- map["ProductCode"]
        eanUpc                  <- map["EanUpc"]
        unitOfMeasure           <- map["UnitOfMeasure"]
        quantity                <- (map["Quantity"], NSDecimalNumberTransform())
        itemAmount              <- (map["ItemAmount"],NSDecimalNumberTransform())
        rebateLabel             <- map["RebateLabel"]
    }
    
    
}
