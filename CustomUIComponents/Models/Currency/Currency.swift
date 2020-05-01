//  Created by Fabio Quintanilha on 4/18/20.
//  Copyright © 2020 TaskHackers. All rights reserved.

import Foundation

struct Currency: NumeralDecoratorProtocol {
    private var amount: Int64 = 0
    private var type: LocalCurrencies!
    private var stringInput: String!
    public private (set) var value: Double?
    
    init(type: LocalCurrencies) {
        self.type = type
    }
    
    mutating func defaultPlaceholder() -> String {
        do {
            return try self.decorate(digitChar: "0")
        } catch {
            return "$0.00"
        }
    }
    
    mutating func decorate(digitChar: String?) throws -> String {
        guard let char = digitChar else { throw CustomEntryError.invalidInput }
        
        if char.count <= 1 {
            var valueAmount: Int64 = 0
            
            if digitChar == "" {
                self.amount = self.amount / 10
            } else {
                guard let digit = Int64(char) else { throw CustomEntryError.invalidInput }
                self.amount = (self.amount * 10) + digit
            }
            valueAmount = self.amount
            guard let value = try getNumeralValue(amount: valueAmount) else {
                throw CustomEntryError.invalidInput
            }
            self.value = value
            return self.type.format(value: value)
        } else {
            var valueAmount: Double = 0
            guard let digits = Double(char) else { return char }
            valueAmount = digits
            guard let value = try getNumeralValue(amount: valueAmount) else {
                throw CustomEntryError.invalidInput
            }
            self.value = value
            return self.type.format(value: value)
        }
    }
    
    internal func getNumeralValue<T>(amount: T) throws -> Double? {
       return try CustomNumberFormatter.currency(value: amount).formattedValue()
    }
}
 
