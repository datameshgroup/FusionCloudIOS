//
//  LogoutResponse.swift
//  FusionCloud
//
//  Created by Loey Agdan on 5/30/22.
//

import Foundation
import ObjectMapper

public class LogoutResponse: Mappable, ResponseType {
    
    public var response: Response?
    public var poiSystemData: POISystemData?
    
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        response        <-  map["Result"]
        poiSystemData   <-  map["POISystemData"]
    }
}
