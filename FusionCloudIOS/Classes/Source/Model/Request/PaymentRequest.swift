import Foundation
import ObjectMapper

public class PaymentRequest: Mappable {

  public var saleData: SaleData?
  public var paymentTransaction: PaymentTransaction?
  public var paymentData: PaymentData?
  public var customFields: [CustomField]?
    
  public func mapping(map: Map) {
    saleData            <- map["SaleData"]
    paymentTransaction  <- map["PaymentTransaction"]
    paymentData         <- map["PaymentData"]
    customFields        <- map["CustomFields"]
  }

  public required init?(map: Map) {}
  public required init() {}
}

public class SaleData: Mappable {

  public var operatorID: String?
  public var operatorLanguage: String?
  public var shiftNumber: String?
  public var customerLanguage: String?
  public var saleTransactionID: SaleTransactionID?
  public var saleReferenceID: String?
  public var saleTerminalData: SaleTerminalData?
  /// Transaction, Customer
  public var tokenRequestedType: String?

  public func mapping(map: Map) {
    operatorID <- map["OperatorID"]
    operatorLanguage <- map["OperatorLanguage"]
    shiftNumber <- map["ShiftNumber"]
    customerLanguage <- map["CustomerLanguage"]
    saleTransactionID <- map["SaleTransactionID"]
    saleReferenceID <- map["SaleReferenceID"]
    saleTerminalData <- map["SaleTerminalData"]
    tokenRequestedType <- map["TokenRequestedType"]
  }

  public required init?(map: Map) {}
  public required init() {}
}

public class SaleTransactionID: Mappable {

  public var transactionID: String?
  public var timeStamp: Date?

  public func mapping(map: Map) {
      transactionID <- map["TransactionID"]
      timeStamp     <- (map["TimeStamp"], ISO8601DateTransform())
  }

  public required init?(map: Map) {}
  public required init() {}
    public required init(transactionID: String) {
        self.transactionID = transactionID;
        self.timeStamp = Date()
    }
}

public class PaymentData: Mappable {
  public var paymentType: PaymentType?
  public var paymentInstrumentData: PaymentInstrumentData?

  public func mapping(map: Map) {
    paymentType             <- map["PaymentType"]
//    paymentInstrumentData   <- map["PaymentInstrumentData"]
  }

  public required init?(map: Map) {
  }
  public required init() {
      paymentType = .Normal
  }
  public required init(paymentType: PaymentType) {
      self.paymentType = paymentType;
  }
}

public class PaymentTransaction: Mappable {
    public var amountsReq: AmountsReq?
    public var origionalPOITransaction: OrigionalPOITransaction?
    public var saleItem: [SaleItem]?
    public var transactionConditions: TransactionConditions?

  public func mapping(map: Map) {
    amountsReq <- map["AmountsReq"]
    saleItem <- map["SaleItem"]
  }

  public required init?(map: Map) {}
  public required init() {}
}

public class TransactionConditions: Mappable {
    public var allowedPaymentBrands: [String]?
    public var acquirerID: [String]?
    public var debitPreferredFlag: Bool?
    public var forceOnlineFlag: Bool?
    public var merchantCategoryCode: String?
    
    public func mapping(map: Map) {
        allowedPaymentBrands <- map["AllowedPaymentBrands"]
        acquirerID           <- map["AcquirerID"]
        debitPreferredFlag   <- map["DebitPreferredFlag"]
        forceOnlineFlag      <- map["ForceOnlineFlag"]
        merchantCategoryCode <- map["MerchantCategoryCode"]
    }
    
    public required init?(map: Map) {}
    public required init() {}
}

public class OrigionalPOITransaction: Mappable {
    public var saleID: String?
    public var poiID: String?
    public var poiTransactionID: POITransactionID?
    public var reuseCardDataFlag: Bool?
    public var approvalCode: String?
    public var lastTransactionFlag: Bool?
    
    public func mapping(map: Map) {
        saleID              <- map["SaleID"]
        poiID               <- map["POIID"]
        poiTransactionID    <- map["POITransactionID"]
        reuseCardDataFlag   <- map["ReuseCardDataFlag"]
        approvalCode        <- map["ApprovalCode"]
        lastTransactionFlag <- map["LastTransactionFlag"]
    }
    
    public required init?(map: Map) {}
    public required init() {}
}



public class AmountsReq: Mappable {
  public var currency: String?
  public var requestedAmount: NSDecimalNumber?
  public var cashBackAmount: NSDecimalNumber?
  public var tipAmount: NSDecimalNumber?
  public var surchargeAmount: NSDecimalNumber?
  public var paidAmount: NSDecimalNumber?
  public var maximumCashBackAmount: NSDecimalNumber?
  public var minimumSplitAmount: NSDecimalNumber?

  public func mapping(map: Map) {
    currency        <- map["Currency"]
    requestedAmount <- (map["RequestedAmount"], NSDecimalNumberTransform())
    cashBackAmount  <- (map["CashBackAmount"], NSDecimalNumberTransform())
    tipAmount       <- (map["TipAmount"], NSDecimalNumberTransform())
    surchargeAmount <- (map["surchargeAmount"], NSDecimalNumberTransform())
    paidAmount      <- (map["paidAmount"], NSDecimalNumberTransform())
    maximumCashBackAmount   <- (map["MaximumCashBackAmount"], NSDecimalNumberTransform())
    minimumSplitAmount      <- (map["MinimumSplitAmount"], NSDecimalNumberTransform())
  }

  public required init?(map: Map) {}
  public required init() {}
}

public class SaleItem: Mappable {

  public var itemID: Int64?
  public var productCode: String?
  public var eanUpc: String?
  public var unitOfMeasure: String?
  public var quantity: NSDecimalNumber?
  public var unitPrice: NSDecimalNumber?
  public var itemAmount: NSDecimalNumber?
  public var taxCode: String?
  public var saleChannel: String?
  public var productLabel: String?
  public var additionalProductInfo: String?
  public var parentItemID: Int64?
  public var costBase: NSDecimalNumber?
  public var discount: NSDecimalNumber?
  public var categories: [String]?
  public var brand: String?
  public var quantityInStock: NSDecimalNumber?
  public var tags: [String]?
  public var restricted: Bool?
  public var pageURL: String?
  public var imageURLs:[String]?
  public var style: String?
  public var size: String?
  public var colour: String?
  public var weight: NSDecimalNumber?
  public var weightUnitOfMeasure: String?
  public var customFields: [CustomField]?

  public func mapping(map: Map) {
    itemID                  <- map["ItemID"]
    productCode             <- map["ProductCode"]
    eanUpc                  <- map["EanUpc"]
    unitOfMeasure           <- map["UnitOfMeasure"]
    quantity                <- (map["Quantity"], NSDecimalNumberTransform())
    unitPrice               <- (map["UnitPrice"], NSDecimalNumberTransform())
    itemAmount              <- (map["ItemAmount"],NSDecimalNumberTransform())
    taxCode                 <- map["TaxCode"]
    saleChannel             <- map["SaleChannel"]
    productLabel            <- map["ProductLabel"]
    additionalProductInfo   <- map["AdditionalProductInfo"]
    parentItemID            <- map["ParentItemID"]
    costBase                <- (map["CostBase"],NSDecimalNumberTransform())
    discount                <- (map["Discount"],NSDecimalNumberTransform())
    categories              <- map["Categories"]
    brand                   <- map["Brand"]
    quantityInStock         <- (map["QuantityInStock"],NSDecimalNumberTransform())
    tags                    <- map["Tags"]
    restricted              <- map["Restricted"]
    pageURL                 <- map["PageURL"]
    imageURLs               <- map["ImageURLs"]
    style                   <- map["Style"]
    size                    <- map["Size"]
    colour                  <- map["Colour"]
    weight                  <- (map["Weight"],NSDecimalNumberTransform())
    weightUnitOfMeasure     <- map["WeightUnitOfMeasure"]
    customFields            <- map["CustomFields"]
  }
  public required init?(map: Map) {}
  public required init() {}
}


