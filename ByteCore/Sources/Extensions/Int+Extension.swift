//
//  Int+Extension.swift
//  ByteCore
//
//  Created by Stefan Adisurya on 07/09/23.
//

import Foundation

extension Int {
    public var currencyDescription: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id-ID")
        formatter.numberStyle = .currency
        
        let formattedNumber = formatter.string(from: NSNumber(integerLiteral: self))
        let defaultFormattedNumber = "Rp\(formatted().replacingOccurrences(of: ",", with: "."))"

        return formattedNumber ?? defaultFormattedNumber
    }
}
