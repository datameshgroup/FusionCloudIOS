//
//  TransactionStatusRequest.swift
//  TestAppDM
//
//  Created by Loey Agdan on 5/8/22.
//

import Foundation
import ObjectMapper

public class TransactionStatusRequest: Mappable, Request {
    
    
    public var messageReference: MessageReference?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        messageReference     <-  map["MessageReference"]
    }
}

public class MessageReference: Mappable {
    
    public var messageCategory: MessageCategory?
    public var serviceID: String?
    public var saleID: String?
    public var poiID: String?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        messageCategory <-      map["MessageCategory"]
        serviceID       <-      map["ServiceID"]
        saleID          <-      map["SaleID"]
        poiID           <-      map["POIID"]
    }
}
