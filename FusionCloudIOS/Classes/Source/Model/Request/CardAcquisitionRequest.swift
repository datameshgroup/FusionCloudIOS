//
//  CardAcquisitionRequest.swift
//  TestAppDM
//
//  Created by Loey Agdan on 5/8/22.
//

import Foundation
import ObjectMapper

public class CardAcquisitionRequest: Mappable, Request {
    
    public var saleData: SaleData?
    public var cardAcquisitionTransaction: CardAcquisitionTransaction?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        saleData                <-  map["SaleData"]
        cardAcquisitionTransaction    <-  map["CardAcquisitionTransaction"]
    }
}

public class CardAcquisitionTransaction: Mappable {
    
    public var allowedPaymentBrand: [String]?
    public var forceEntryMode: String?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        allowedPaymentBrand      <-  map["AllowedPaymentBrand"]
        forceEntryMode          <-  map["ForceEntryMode"]
    }
}


