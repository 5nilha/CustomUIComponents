//  Created by Fabio Quintanilha on 4/30/20.
//  Copyright © 2020 TaskHackers. All rights reserved.
//

import Foundation

struct Percentage: NumeralDecoratorProtocol {
    private var amount: Int64 = 0
    private var type: LocalPercentages = .regular
    private var stringInput: String!
    public private (set) var value: Double?
    
    init(type: LocalPercentages) {
        self.type = type
    }
    
    mutating func defaultPlaceholder() -> String {
        do {
            return try self.decorate(digitChar: "0")
        } catch {
            return "0%"
        }
    }
    
    mutating func decorate(digitChar: String?) throws -> String {
        guard let char = digitChar else { throw CustomEntryError.invalidInput }

          if char.count <= 1 {
            if digitChar == "" {
                self.amount = self.amount / 10
            } else {
                guard let digit = Int64(char) else { throw CustomEntryError.invalidInput }

                self.amount = (self.amount * 10) + digit
            }
            guard let value = try getNumeralValue(amount: self.amount) else {
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
        switch self.type {
        case .regular:
            let value = try CustomNumberFormatter.percentage(value: amount).formattedValue()
            return value
        case .decimal:
            let value = try CustomNumberFormatter.decimalPercentage(value: amount).formattedValue()
            return value
        }
    }
}
