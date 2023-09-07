//
//  AbortResponse.swift
//  FusionCloud
//
//  Created by Loey Agdan on 5/30/22.
//

import Foundation
import ObjectMapper


public class AbortResponse: Mappable, ResponseType {
    
    public var timeStamp: Date?
    public var eventToNotify: String?
    public var eventDetails: String?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        timeStamp       <- (map["TimeStamp"], ISO8601DateTransform())
        eventToNotify   <-  map["EventToNotify"]
        eventDetails    <-  map["EventDetails"]
    }
}
