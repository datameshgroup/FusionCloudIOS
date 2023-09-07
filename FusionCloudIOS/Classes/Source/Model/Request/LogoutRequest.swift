//
//  LogoutRequest.swift
//  FusionCloud
//
//  Created by Loey Agdan on 5/30/22.
//

import Foundation
import ObjectMapper

public class LogoutRequest: Mappable, Request {
    
    public var maintenanceAllowed: Bool?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        maintenanceAllowed     <-  map["MaintenanceAllowed"]
    }
}
