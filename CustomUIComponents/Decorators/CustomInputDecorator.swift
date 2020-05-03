//  Created by Fabio Quintanilha on 4/20/20.
//  Copyright © 2020 TaskHackers. All rights reserved.


import Foundation

class CustomInputDecorator {
    private var type: CustomInputType!
    private var decorator: NumeralDecoratorProtocol!
    
    init(type: CustomInputType) {
        self.type = type
        self.setDecorator()
    }
    
    private func setDecorator() {
        switch self.type {
        case .currency(let currencyType):
            decorator = Currency(type: currencyType)
        case .percentage(let percentageType):
            decorator = Percentage(type: percentageType)
        case .email:
            break
        case .password:
            break
        default:
            break
        }
    }
    
    func decorate(character: String?) throws -> String {
        let decoratedString = try self.decorator.decorate(digitChar: character)
        return decoratedString
    }
    
    var maxValue: Int {
        return type.maxCharacters
    }
    
    func defaultPlaceholder() throws -> String {
        return self.decorator.defaultPlaceholder()
    }
    
    var titlePlaceholder: String {
        return type.titlePlaceholder
    }
    var defaultText: String! {
        if self.decorator is Currency {
            let decorator = self.decorator as! Currency
            return "\(decorator.doubleValue)"
        }
        else {
            let decorator = self.decorator as! Percentage
            return "\(decorator.doubleValue)"
        }
    }
}
