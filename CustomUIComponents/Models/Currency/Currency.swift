//  Created by Fabio Quintanilha on 4/18/20.
//  Copyright © 2020 TaskHackers. All rights reserved.

import Foundation

struct Currency {
    
    static var amount: Int64 = 0
    static let maxValue = 20
    private var currencyType: Currencies!
    private var stringInput: String!
    public private (set) var value: Double?
    
    init(type: Currencies) {
        self.currencyType = type
    }
    
    mutating func decorate(digitChar: String?) throws -> String {
        guard let char = digitChar else { throw CustomEntryError.invalidInput }
        
        if char.count <= 1 {
            var valueAmount: Int64 = 0
            if let digit = Int64(char) {
                Currency.amount = (Currency.amount * 10) + digit
            }
               
            if digitChar == "" {
                Currency.amount = Currency.amount / 10
            }
            valueAmount = Currency.amount
            guard let value = try getNumeralValue(amount: valueAmount, currencyType: currencyType) else {
                throw CustomEntryError.invalidInput
            }
            self.value = value
            return self.currencyType.format(value: value)
        } else {
            var valueAmount: Double = 0
            guard let digits = Double(char) else { return char }
            valueAmount = digits
            guard let value = try getNumeralValue(amount: valueAmount, currencyType: currencyType) else {
                throw CustomEntryError.invalidInput
            }
            self.value = value
            return self.currencyType.format(value: value)
        }
    }
    
    private func getNumeralValue<T>(amount: T, currencyType: Currencies) throws -> Double? {
       return try CustomNumberFormatter.currency(value: amount).formattedValue()
    }
}
 
