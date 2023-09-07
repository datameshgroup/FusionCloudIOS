//
//  PaymentResponseSaleData.swift
//  FusionCloud
//
//  Created by Vanessa on 12/4/2023.
//

import Foundation
import ObjectMapper

public class PaymentResponseSaleData: Mappable{
    
    public var saleTransactionID: SaleTransactionID?
    public var saleReferenceID: String?
    
    public required init?(map: Map) {}
    public func mapping(map: Map) {
        saleTransactionID   <- map["SaleTransactionID"]
        saleReferenceID     <- map["SaleReferenceID"]
    }
}
