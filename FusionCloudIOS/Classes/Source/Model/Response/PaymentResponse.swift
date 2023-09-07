//
//  PaymentResponse.swift
//  TestAppDM
//
//  Created by Loey Agdan on 4/21/22.
//

import Foundation
import ObjectMapper


public class PaymentResponse: Mappable, ResponseType {
    
    /**
     * Input Request/Response
     * Print Request/Response
     * Transaction Status Request/Response
     * Abort Transaction Request/Response
     * Reconciliation Request/Response
     * Card Acquisition Request/Response**/
    
    public var response: PResponse?
    public var saleData: PaymentResponseSaleData?
    public var poiData: POIData?
    public var paymentResult: PaymentResult?
    public var allowedProductCodes: [String]?
    public var paymentReceipt: [PaymentReceipt]?
    public var loyaltyResult: [LoyaltyResult]?

    
    public required init?(map: Map) {}
    public init(){}
    public func mapping(map: Map) {
        response            <-  map["Response"]
        saleData            <-  map["SaleData"]
        poiData             <-  map["POIData"]
        paymentResult       <-  map["PaymentResult"]
        allowedProductCodes <-  map["AllowedProductCodes"]
        paymentReceipt      <-  map["PaymentReceipt"]
        loyaltyResult       <-  map["LoyaltyResult"]
    }
    /// TODO
   
}

public class PResponse: Mappable {
        
    public var result: ResponseResult?
    public var errorCondition: ErrorCondition?
    public var additionalResponse: String?
        
    public init(){}
    public required init?(map: Map) {}
    public func mapping(map: Map) {
        result              <-  map["Result"]
        errorCondition      <-  map["ErrorCondition"]
        additionalResponse  <-  map["AdditionalResponse"]
    }
    
    public func isSuccess() -> Bool {
        let r = result
        return (r == ResponseResult.Success)
    }
}


public class POIData: Mappable {
    
    public var poiReconciliationID: String?
    public var poiTransactionID: POITransactionID?
    public var allowedProductCodes: [String]?
    
    public init(){}
    public required init?(map: Map) {}
    public func mapping(map: Map) {
        poiTransactionID      <-  map["POITransactionID"]
        poiReconciliationID   <-  map["POIReconciliationID"]
        allowedProductCodes   <-  map["AllowedProductCodes"]
    }
}

public class POITransactionID: Mappable {
    
    public var transactionID:String?
    public var timeStamp: Date?
    
    public init(){}
    public required init?(map: Map) {}
    public func mapping(map: Map) {
        transactionID       <-  map["TransactionID"]
        timeStamp           <-  (map["TimeStamp"], ISO8601DateTransform())
    }
}

public class PaymentResult: Mappable {
    /// Normal, Refund
    public var paymentType: PaymentType?
    public var onlineFlag: Bool?
    public var amountsResp: AmountsResp?
    public var paymentInstrumentData: PaymentInstrumentData?
    public var paymentAcquirerData: PaymentAcquirerData?
    
    public init(){}
    public required init?(map: Map) {}
    public func mapping(map: Map) {
        paymentType           <- map["PaymentType"]
        onlineFlag            <- map["OnlineFlag"]
        amountsResp           <- map["AmountsResp"]
        paymentInstrumentData <- map["PaymentInstrumentData"]
        paymentAcquirerData   <- map["PaymentAcquirerData"]
    }
}

public class AmountsResp: Mappable {
        
    public var currency: String?
    public var authorizedAmount: NSDecimalNumber?
    public var totalFeesAmount: NSDecimalNumber?
    public var cashBackAmount: NSDecimalNumber?
    public var tipAmount: NSDecimalNumber?
    public var surchargeAmount: NSDecimalNumber?
    public var partialAuthorizedAmount: NSDecimalNumber?
        
    public init(){}
    public required init?(map: Map) {}
    public func mapping(map: Map) {
        currency                <-      map["Currency"]
        authorizedAmount        <-      (map["AuthorizedAmount"], NSDecimalNumberTransform())
        totalFeesAmount         <-      (map["TotalFeesAmount"], NSDecimalNumberTransform())
        cashBackAmount          <-      (map["CashBackAmount"], NSDecimalNumberTransform())
        tipAmount               <-      (map["TipAmount"], NSDecimalNumberTransform())
        surchargeAmount         <-      (map["SurchargeAmount"], NSDecimalNumberTransform())
        partialAuthorizedAmount <-      (map["PartialAuthorizedAmount"], NSDecimalNumberTransform())
    }
}

    public class PaymentAcquirerData: Mappable {
        
        public var acquirerID: String?
        public var merchantID: String?
        public var acquirerPOIID: String?
        public var approvalCode: String?
        public var responseCode: String?
        public var hostReconcilationID: String?
        public var acquirerTransactionID: AcquirerTransactionID?
        public var rrn: String?
        public var stan: String?
        
        public init(){}
        public required init?(map: Map) {}
        public func mapping(map: Map) {
            acquirerID              <-  map["AcquirerID"]
            merchantID              <-  map["MerchantID"]
            acquirerPOIID           <-  map["AcquirerPOIID"]
            approvalCode            <-  map["ApprovalCode"]
            acquirerTransactionID   <-  map["AcquirerTransactionID"]
            responseCode            <-  map["ResponseCode"]
            hostReconcilationID     <-  map["HostReconciliationID"]
            rrn                     <-  map["RRN"]
            stan                    <-  map["STAN"]
        }
    }


        public class AcquirerTransactionID: Mappable {
            
            public var transactionID: String?
            public var timeStamp: Date?
            
            public init(){}
            public required init?(map: Map) {}
            public func mapping(map: Map) {
                transactionID       <-  map["TransactionID"]
                timeStamp           <- (map["TimeStamp"], ISO8601DateTransform())
            }
        }

    public class PaymentInstrumentData: Mappable {
        
        /// Card, Check, Mobile, StoredValue, Cash
        public var paymentInstrumentType: PaymentInstrumentType?
        
        /// Present if PaymentInstrumentType==Card
        public var cardData: CardData?
   
        
        public required init(){}
        public required init?(map: Map) {}
        public func mapping(map: Map) {
            paymentInstrumentType <- map["PaymentInstrumentType"]
            cardData              <- map["CardData"]
        }
    }

    public class PaymentToken: Mappable {
        
        public var tokenRequestType:String?
        public var tokenValue:String?
        public var expiryDateTime: String?
        
        public required init(){}
        public required init?(map: Map) {}
        public func mapping(map: Map) {
            tokenRequestType        <-      map["TokenRequestedType"]
            tokenValue              <-      map["TokenValue"]
            expiryDateTime          <-      map["ExpiryDateTime"]
        }
    }

    public class CardData: Mappable {
        
        /// RFID, Keyed, Manual, File, Scanned, MagStripe, ICC, SynchronousICC, Tapped, Contactless, Mobile
        public var entryMode: EntryMode?
        public var paymentBrand: String? //PaymentBrand?
        public var maskedPan: String?
        public var account: String? ///Present if  EntryMode is "MagStripe", "ICC", or "Tapped"
        public var paymentToken: PaymentToken?
        
        public required init(){}
        public required init?(map: Map) {}
        public func mapping(map: Map) {
            entryMode       <- map["EntryMode"]
            paymentBrand    <- map["PaymentBrand"]
            maskedPan       <- map["MaskedPAN"]
            account         <- map["Account"]
            paymentToken    <- map["PaymentToken"]
        }
        public func getAccount() -> String {
            let cardAccount = account ?? "Default"
            let accountList = ["Credit", "Cheque", "Savings", "Default"]
            if(accountList.contains(cardAccount)){
                return cardAccount
            }else{
                return "Default"
            }
        }
        public func getPaymentBrand() -> String {
            let brand = paymentBrand?.lowercased().trimmingCharacters(in: .whitespaces) ?? "Default"
            let paymentBrandList = ["visa", "mastercard", "americanexpress", "dinersclub", "jcb", "unionpay", "cupdebit", "discover", "card"]
            
            if(paymentBrandList.contains(brand)){
                return paymentBrand ?? "Default"
            }else{
                return "Default"
            }
        }
    }

public class PaymentReceipt: Mappable {
    
    /// Indicates the type of recipt. Possible values: SaleReceipt, CashierReceipt, CustomerReceipt, Document, Voucher, Journal
    public var documentQualifier: String?
    /// Indicates if the receipt should be included in te sale result.
    public var integratedPrintFlag: Bool?
    /// True if signature is required
    public var requiredSignatureFlag: Bool?
    /// Receipt content to print
    public var outputContent: OutputContent?
    
    public required init(){}
    public required init?(map: Map) {}
    public func mapping(map: Map) {
        documentQualifier     <- map["DocumentQualifier"]
        integratedPrintFlag   <- map["IntegratedPrintFlag"]
        requiredSignatureFlag <- map["RequiredSignatureFlag"]
        outputContent         <- map["OutputContent"]
    }
    public func getReceiptAsPlainText() -> String? {
        
        let receipt = outputContent?.outputXHTML ?? ""
        
        if(receipt == "") {
            return ""
        }

        return receipt.base64Decoded()
    }
}
extension String {
//: ### Base64 encoding a string
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
//: ### Base64 decoding a string
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }

}
