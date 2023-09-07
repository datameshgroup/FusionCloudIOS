//
//  SalePOIRequest.swift
//  FusionCloud
//
//  Created by Loey Agdan on 7/17/22.
//

import Foundation
import ObjectMapper

public class SaleToPOIRequest : Mappable, Request {
    
    public var messageHeader: MessageHeader?
    public var abortRequest: AbortRequest?
    public var paymentRequest: PaymentRequest?
    public var loginRequest: LoginRequest?
    public var cardAcquisitionRequest: CardAcquisitionRequest?
    public var displayRequest: DisplayRequest?
    public var inputRequest: InputRequest?
    public var logoutRequest: LogoutRequest?
    public var printRequest: PrintRequest?
    public var reconcilliationRequest: ReconcillationRequest?
    public var transactionStatusRequest: TransactionStatusRequest?
    public var reversalRequest: ReversalRequest?
    public var securityTrailer: SecurityTrailer?
    public var eventNotification: EventNotification?
    
    public required init?(map: Map) {}
    public required init() {}
    public func mapping(map: Map) {
        messageHeader           <- map["MessageHeader"]
        abortRequest            <- map["AbortRequest"]
        paymentRequest          <- map["PaymentRequest"]
        loginRequest            <- map["LoginRequest"]
        cardAcquisitionRequest  <- map["CardAcquisitionRequest"]
        displayRequest          <- map["DisplayRequest"]
        inputRequest            <- map["InputRequest"]
        logoutRequest           <- map["LogoutRequest"]
        printRequest            <- map["PrintRequest"]
        reconcilliationRequest   <- map["ReconcillationRequest"]
        transactionStatusRequest    <- map["TransactionStatusRequest"]
        reversalRequest         <- map["ReversalRequest"]
        securityTrailer         <- map["SecurityTrailer"]
        eventNotification       <- map["EventNotification"]
    }
}
