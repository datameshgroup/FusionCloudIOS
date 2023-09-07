//
//  EventNotification.swift
//  FusionCloud
//
//  Created by Vanessa on 12/4/2023.
//

import Foundation
import ObjectMapper

public class EventNotification: Mappable, ResponseType {
    
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
