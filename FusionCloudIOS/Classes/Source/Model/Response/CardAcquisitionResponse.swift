//
//  CardAcquisitionResponse.swift
//  FusionCloud
//
//  Created by Loey Agdan on 5/30/22.
//

import Foundation
import ObjectMapper

public class CardAcquisitionResponse: Mappable, ResponseType {
    
    public var response: Response?
    public var saleData: SaleData?
    public var poiData: POIData?
    public var paymentInstrumentData: PaymentInstrumentData?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        response               <-      map["Response"]
        saleData               <-      map["SaleData"]
        poiData                <-      map["POIData"]
        paymentInstrumentData  <-      map["PaymentInstrumentData"]
    }
}

