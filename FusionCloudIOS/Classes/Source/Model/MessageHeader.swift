//
//  MessageHeader.swift
//  TestApplication
//
//  Created by loey on 1/30/22.
//  Copyright © 2022 loey. All rights reserved.
//

import Foundation
import ObjectMapper

public class MessageHeader : Mappable {
    
        public var messageClass: MessageClass?
        public var messageCategory: MessageCategory?
        public var messageType: MessageType?
        public var serviceID: String?
        public var deviceID: String?
    
        // these fields are required for cloud POS
        public var protocolVersion: String?
        public var saleID: String!
        public var poiID: String!
    
    
    public required init?(map: Map) {}
    public required init(){}
    
     public func mapping(map: Map) {
         messageClass           <- map["MessageClass"]
         messageCategory        <- map["MessageCategory"]
         messageType            <- map["MessageType"]
         serviceID              <- map["ServiceID"]
         deviceID               <- map["DeviceID"]

         protocolVersion        <- map["ProtocolVersion"]
         saleID                 <- map["SaleID"]
         poiID                  <- map["POIID"]
     }
    
}
