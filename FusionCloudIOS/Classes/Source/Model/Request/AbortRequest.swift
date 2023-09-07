//
//  AbortRequest.swift
//  TestAppDM
//
//  Created by Loey Agdan on 5/8/22.
//

import Foundation
import ObjectMapper

public class AbortRequest: Mappable {
    
    public var messageReference: MessageReference?
    public var abortReason: String?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        messageReference        <-  map["MessageReference"]
        abortReason             <-  map["AbortReason"]
    }
}

