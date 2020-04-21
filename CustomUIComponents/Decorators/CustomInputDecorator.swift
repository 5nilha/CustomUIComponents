//  Created by Fabio Quintanilha on 4/20/20.
//  Copyright © 2020 TaskHackers. All rights reserved.


import Foundation

class CustomInputDecorator {
    private var type: CustomInputType!
    
    init(type: CustomInputType) {
        self.type = type
    }
    
    func decorate(character: String?) throws -> String {
        switch self.type {
        case .currency(let currencyType):
            var currency = Currency(type: currencyType)
            return try currency.decorate(digitChar: character)
        case .percentage:
            self.setPercentage()
            return ""
        case .email:
            self.setEmail()
            return ""
        case .password:
            self.setPassword()
            return ""
        default:
            return ""
        }
    }
    
    var maxValue: Int {
        return type.maxValue
    }
    
    func defaultPlaceholder() throws -> String {
        switch self.type {
        case .currency(let currencyType):
            var currency = Currency(type: currencyType)
            return try currency.decorate(digitChar: "0")
        case .percentage:
            self.setPercentage()
            return ""
        case .email:
            self.setEmail()
            return ""
        case .password:
            self.setPassword()
            return ""
        default:
            return ""
        }
    }
    
    var titlePlaceholder: String {
        return type.titlePlaceholder
    }
    
    private func setPercentage() {
       
    }
    
    private func setEmail() {
        
    }
    
    private func setPassword() {
        
    }
    
}
