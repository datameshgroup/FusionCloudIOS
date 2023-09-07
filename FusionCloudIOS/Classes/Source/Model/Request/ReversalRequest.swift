//
//  ReversalRequest.swift
//  FusionCloud
//
//  Created by Vanessa on 12/4/2023.
//

import Foundation
import ObjectMapper

public class ReversalRequest: Mappable,Request {
    
    public var reversalReason: ReversalReason?
    public var originalPOITransaction: OrigionalPOITransaction?
    
    public required init?(map: Map) {}
    public func mapping(map: Map) {
        reversalReason          <- map ["ReversalReason"]
        originalPOITransaction  <- map ["OriginalPOITransaction"]
    }
}
