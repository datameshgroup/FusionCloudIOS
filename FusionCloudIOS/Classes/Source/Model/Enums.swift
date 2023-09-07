//
//  Enums.swift
//  FusionCloud
//
//  Created by Vanessa on 12/4/2023.
//

import Foundation

public enum MessageCategory: String {
    case Abort,
    Admin,
    BalanceInquiry,
    //*Batch,
    CardAcquisition,
    //*CardReaderAPDU,
    //*CardReaderInit,
    //*CardReaderPowerOff,
    //*Diagnosis,
    Display,
    //*EnableService,
    Event,
    //*GetTotals,
    Input,
    //*InputUpdate,
    Login,
    Logout,
    //*Loyalty,
    Payment,
    //*PIN,
    Print,
    Reconciliation,
    Reversal,
    //*Sound,
    //*StoredValue,
    //*TransactionReport,
    TransactionStatus,
    //*Transmit,
    Other
}
/* These fields are part of the Nexo specification but not currently implemented into the DataMesh host. */

 public enum TerminalEnvironment: String {
     case Attended,
     SemiAttended,
     Unattended,
     Unknown
 }

public enum SaleCapability: String {
    case CashierStatus,
    CashierError,
    CashierInput,
    CustomerAssistance,
    PrinterReceipt,
    Unknown
}

//TODO: Translate java below to swift
//public enum PaymentBrand {
//    @Json(name = "VISA") VISA,
//    Mastercard,
//    @Json(name = "American Express") AmericanExpress,
//    @Json(name = "Diners Club") DinersClub,
//    JCB,
//    @Json(name = "UnionPay") UnionPay,
//    @Json(name = "CUP Debit") CUPDebit,
//    Discover,
//    Debit,
//    AliPay,
//    @Json(name = "WeChat Pay") WeChatPay,
//    Card,
//    @Json(name = "CryptoDotCom") CryptoDotCom,
//    @Json(name = "BPGiftCard") BPGiftCard,
//    @Json(name = "QantasPoints") QantasPoints,
//    @Json(name = "DRCDollars") DRCDollars,
//    @Json(name = "Cash") Cash,
//    Other
//}


public enum PaymentType: String {
    case Normal,
    Reversal,
    Refund,
    CashAdvance,
    FirstReservation,
    Completion
}

public enum PaymentInstrumentType: String {
    case Card,
    Check,
    Cash,
    Mobile,
    Other,
    Unspecified
}

public enum EntryMode: String {
    case File,
    Keyed,
    Manual,
    Scanned,
    MagStripe,
    ICC, //Contact ICC (asynchronous)
    SynchronousICC, //Contact ICC (synchronous)
    Tapped,
    Mobile,
    RFID,
    Contactless,
    Unknown
}
public enum InfoQualify: String {
    case Status,
    Error,
    Display,
    Input,
    POIReplication,
    CustomerAssitance,
    Unknown
}
public enum InputCommand: String {
    case GetAnyKey,
    GetConfirmation,
    Password,
    GetMenuEntry,
    TextString,
    DigitString,
    DecimalString,
    Unknown
}
public enum ReversalReason: String {
    case CustCancel,
    MerchantCancel,
    Malfunction,
    Unable2Compl,
    SignatureDeclined,
    Unknown
}
public enum ErrorCondition: String {
    case Aborted,
    Busy,
    Cancel,
    DeviceOut,
    InsertedCard,
    InProgress,
    LoggedOut,
    MessageFormat,
    NotAllowed,
    NotFound,
    PaymentRestriction,
    Refusal,
    UnavailableDevice,
    UnavailableService,
    InvalidCard,
    UnreachableHost,
    WrongPIN,
    Unknown
}
public enum ResponseResult: String {
    case Success,
    Failure,
    Partial,
    Unknown
}

public enum CurrencySymbol: String {
    case AUD,
    Unknown
}

public enum POICapability: String {
    case MagStripe,
    ICC,
    EMVContactless
}
public enum TransactionType: String {
    case Debit,
    Credit,
    CashAdvance,
    ReverseDebit,
    ReverseCredit,
    OneTimeReservation,
    CompletedDeferred,
    FirstReservation,
    UpdateReservation,
    CompletedReservation,
    Declined,
    Failed,
    Unknown
}
public enum MessageClass: String {
    case Service,
    Device,
    Event
}
public enum MessageType: String {
    case Request,
    Response,
    Notification
}


//LOYALTY
public enum LoyaltyBrand: String {
    case Unknown,
    Qantas,
    DRC,
    Other
}
public enum LoyaltyUnit: String {
        case Point,
        Monetary,
        Uknown
}
public enum IdentificationType: String {
    case PAN,
    ISOTrack2,
    BarCode,
    AccountNumber,
    PhoneNumber,
    Unknown
}
public enum IdentificationSupport: String {
    case NoCard,
    LoyaltyCard,
    HybridCard,
    LinkedCard,
    Unknown
}
