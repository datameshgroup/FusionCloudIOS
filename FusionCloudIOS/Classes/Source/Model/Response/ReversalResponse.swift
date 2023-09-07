//
//  ReversalResponse.swift
//  FusionCloud
//
//  Created by Vanessa on 12/4/2023.
//

import Foundation
import ObjectMapper

public class ReversalResponse: Mappable,ResponseType {
    public var response: Response?
    public var poiData: POIData?
    public var paymentReceipt: [PaymentReceipt]?
    
    public required init?(map: Map) {}
    public func mapping(map: Map) {
        response        <- map["Response"]
        poiData         <- map["POIData"]
        paymentReceipt  <- map["PaymentReceipt"]
    }
}
