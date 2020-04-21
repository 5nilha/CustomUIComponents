//  Created by Fabio Quintanilha on 4/19/20.
//  Copyright © 2020 TaskHackers. All rights reserved.

import Foundation

enum CustomNumberFormatter<T> {
    case currency(value: T)
    case percentage(value: Double)
    case decimalPercentage(value: Double)
    case decimal(value: Double)
    case scientific(value: Double)
    
    private enum NumberOfDecimals {
        case zerodigits
        case oneDigit
        case twoDigits
        case threeDigits
        case fourDigits
        case unknown
        
        private var numberOfDigits: Int {
            switch self {
            case .zerodigits:
                return 0
            case .oneDigit:
                return 1
            case .twoDigits, .unknown:
                return 2
            case .threeDigits:
                return 3
            case .fourDigits:
                return 4
            }
        }
        
        func format<T>(value: T) throws -> Double {
            if value is Double, let valueAmount = value as? Double {
                return self.formatDouble(value: valueAmount)
            } else if value is Int64, let valueAmount = value as? Int64  {
                return formatInt(value: valueAmount)
            } else if value is String, let stringAmount = value as? String {
                guard let string = stringByRemovingCharacters(stringAmount) else { throw CustomEntryError.invalidInput }
                if let valueAmount = Int64(string) {
                    return formatInt(value: valueAmount)
                } else if let valueAmount = Double(string) {
                    return self.formatDouble(value: valueAmount)
                } else {
                    throw CustomEntryError.invalidInput
                }
            } else {
                throw CustomEntryError.invalidInput
            }
        }
        
        private func formatDouble(value: Double) -> Double {
            let digits = pow(10, Double(self.numberOfDigits))
            return Double(round(digits * value) / digits)
        }
        
        private func formatInt(value: Int64) -> Double {
            return Double(value / 100) + Double(value % 100) / 100
        }
        
        private func stringByRemovingCharacters(_ string: String) -> String? {
           let pattern = "[^0-9.]"
           do {
               let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
               
               let numberString = regex.stringByReplacingMatches(in: string, options: NSRegularExpression.MatchingOptions.withTransparentBounds, range: NSMakeRange(0, string.count), withTemplate: "")
               return numberString
           } catch {
               return nil
           }
        }
        
    }

    
    func formattedValue() throws -> Double {
        switch self {
        case .currency(let value):
            return try NumberOfDecimals.twoDigits.format(value: value)
        case .decimal(let value):
            return try NumberOfDecimals.twoDigits.format(value: value)
        case .percentage(let value):
            return try NumberOfDecimals.zerodigits.format(value: value)
        case .decimalPercentage(let value):
            return try NumberOfDecimals.oneDigit.format(value: value)
        case .scientific(let value):
            return try NumberOfDecimals.twoDigits.format(value: value)
        }
    }
}
