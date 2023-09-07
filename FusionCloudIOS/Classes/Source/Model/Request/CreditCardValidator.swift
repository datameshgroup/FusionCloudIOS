//
//  File.swift
//  FusionCloud
//
//  Created by Clinton on 1/9/2022.
//

import Foundation

struct CreditCardValidator {
    
    /// Available credit card types
    private let types: [CreditCardType] = [
        .visa,
        .mastercard,
        .americanexpress,
        .dinersclub,
        .jcb,
        .unionpay,
        .cupdebit,
        .discover,
        //.card
    ]
    
    private let string: String
    
    /// Create validation value
    /// - Parameter string: credit card number
    public init(_ string: String) {
        self.string = string
    }
    
    /// Get card type
    /// Card number validation is not perfroms here
    public var type: CreditCardType? {
        types.first { type in
            NSPredicate(format: "SELF MATCHES %@", type.rawValue)
                .evaluate(
                    with: string
                )
        }
    }
    
    /// Calculation structure
    private struct Calculation {
        let odd, even: Int
        func result() -> Bool {
            (odd + even) % 10 == 0
        }
    }
    
    /// Validate credit card number
    public var isValid: Bool {
        guard let type = type else { return false }
        let isValidLength = type.validNumberLength.contains(string.count)
        return isValidLength //&& isValid(for: string)
    }
    
    /// Validate card number string for type
    /// - Parameters:
    ///   - string: card number string
    ///   - type: credit card type
    /// - Returns: bool value
    public func isValid(for type: CreditCardType) -> Bool {
        isValid && self.type == type
    }
    
    /// Validate string for credit card type
    /// - Parameters:
    ///   - string: card number string
    /// - Returns: bool value
//    private func isValid(for string: String) -> Bool {
//        string
//            .reversed()
//            .compactMap({ Int(String($0)) })
//            .enumerated()
//            .reduce(Calculation(odd: 0, even: 0), { value, iterator in
//                return .init(
//                    odd: odd(value: value, iterator: iterator),
//                    even: even(value: value, iterator: iterator)
//                )
//            })
//            .result()
//    }
    
    private func odd(value: Calculation, iterator: EnumeratedSequence<[Int]>.Element) -> Int {
        iterator.offset % 2 != 0 ? value.odd + (iterator.element / 5 + (2 * iterator.element) % 10) : value.odd
    }

    private func even(value: Calculation, iterator: EnumeratedSequence<[Int]>.Element) -> Int {
        iterator.offset % 2 == 0 ? value.even + iterator.element : value.even
    }
    
}

fileprivate extension String {
 
    var numbers: String {
        let set = CharacterSet.decimalDigits.inverted
        let numbers = components(separatedBy: set)
        return numbers.joined(separator: "")
    }
    
}


public func isCardValid(cardNumber : String, cardBrand: String) -> (isValid: Bool, errorMessage: String){
    let cardNumber = cardNumber.lowercased().trimmingCharacters(in: .whitespaces)
    let cardBrand = "." + cardBrand.lowercased().trimmingCharacters(in: .whitespaces)
    
    var isValid=false
    var errorMessage=""
    
    if !CreditCardValidator(cardNumber).isValid {
      return (false, "Invalid Card Number")
    }
    
    if let type = CreditCardValidator(cardNumber).type {
        isValid = true
        errorMessage = "\(type) " + cardBrand
    } else {
        isValid = false
        errorMessage = "Card Brand not valid"
    }
    return (isValid, errorMessage)
}

public enum CreditCardType: String {
    case visa = "^4[0-9]{4,}([0-9]|[x]){6,}(?:[0-9]{3})?$"
    case mastercard = "^(?:5[1-5][0-9]{2}|222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)([0-9]|[x]){12}$"
    case americanexpress = "^3[47]([0-9]|[x]){5,}$"
    case dinersclub = "^3(?:0[0-5]|[68][0-9])([0-9]|[x]){4,}$"
    case jcb = "^(?:2131|1800|35[0-9]{3})[0-9]|[x]{3,}$"
    case unionpay, cupdebit = "^(62[0-9]{4,}|81[0-9]{4,})([0-9]|[x]){6,}$"
    case discover = "^6(?:011|5[0-9]{2})([0-9]|[x]){3,}$"
    //case card = "^5(?:610|5[0-9]{2})[0-9]{3,}$"
    //5610, 560221-560225 - 16
    /// Possible C/C number lengths for each C/C type
    /// reference: https://en.wikipedia.org/wiki/Payment_card_number
    var validNumberLength: IndexSet {
        switch self {
        case .visa:
            return IndexSet([13,16])
        case .americanexpress:
            return IndexSet(integer: 15)
//        case .card, .mastercard:
//            return IndexSet(integer: 16)
        case .dinersclub:
            return IndexSet(integersIn: 14...19)
        case .jcb, .discover, .unionpay, .cupdebit:
            return IndexSet(integersIn: 16...19)
        default:
            return IndexSet(integer: 16)
        }
    }
}

