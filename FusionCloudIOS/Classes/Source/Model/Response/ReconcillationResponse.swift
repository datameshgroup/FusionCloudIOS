//
//  ReconcillationResponse.swift
//  FusionCloud
//
//  Created by Loey Agdan on 5/30/22.
//

import Foundation
import ObjectMapper

public class ReconciliationResponse: Mappable, ResponseType {
    
    var reconciliationType: String?
    var poiReconciliationID: String?
    var response: Response?
    var transactionTotals: [TransactionTotal]?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        reconciliationType  <-      map["ReconciliationType"]
        poiReconciliationID <-      map["POIReconciliationID"]
        response            <-      map["Response"]
        transactionTotals   <-      map["TransactionTotal"]
    }
}

public class TransactionTotal: Mappable {
    
    var paymentInstrumentType: PaymentInstrumentType?
    var cardBrand: String?
    var tid: String?
    var mid: String?
    var acquirerID: String?
    var lastShiftTotalTime: String?
    var paymentCurrency: String?
    var paymentTotals: [PaymentTotal]?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        paymentInstrumentType   <-  map["PaymentInstrumentType"]
        cardBrand               <-  map["CardBrand"]
        tid                     <-  map["TID"]
        mid                     <-  map["MID"]
        acquirerID              <-  map["AcquirerID"]
        lastShiftTotalTime      <-  map["LastShiftTotalTime"]
        paymentCurrency         <-  map["PaymentCurrency"]
        paymentTotals           <-  map["PaymentTotals"]
    }
}


public class PaymentTotal: Mappable {
    
    
    public var transactionType: TransactionType?
    public var transactionCount: Int64?
    public var transactionAmount: NSDecimalNumber?
    public var tipAmount: NSDecimalNumber?
    public var surchargeAmount: NSDecimalNumber?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        transactionType     <-      map["TransactionType"]
        transactionCount    <-      map["TransactionCount"]
        transactionAmount   <-      (map["TransactionAmount"], NSDecimalNumberTransform())
        tipAmount           <-      (map["TipAmount"], NSDecimalNumberTransform())
        surchargeAmount     <-      (map["SurchargeAmount"], NSDecimalNumberTransform())
    }
}
