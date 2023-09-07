//
//  TransactionStatusResponse.swift
//  FusionCloud
//
//  Created by Loey Agdan on 5/30/22.
//
import Foundation
import ObjectMapper

//response

public class TransactionStatusResponse: Mappable, ResponseType {
    
    public var response: Response?
    public var messageReference: MessageReference?
    public var repeatedMessageResponse: RepeatedMessageResponse?
    
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        response                    <-  map["Response"]
        messageReference            <-  map["MessageReference"]
        repeatedMessageResponse     <-  map["RepeatedMessageResponse"]
    }
}

public class RepeatedMessageResponse: Mappable {
    
    public var repeatedResponseMessageBody: RepeatedResponseMessageBody?
    public var messageHeader: MessageHeader?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        messageHeader                <- map["MessageHeader"]
        repeatedResponseMessageBody  <-  map["RepeatedResponseMessageBody"]
    }
}

public class RepeatedResponseMessageBody: Mappable {
    public var paymentResponse: PaymentResponse?
    public var reversalResponse: ReversalResponse?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        paymentResponse  <-  map["PaymentResponse"]
        reversalResponse <-  map["ReversalResponse"]
        
    }
}
