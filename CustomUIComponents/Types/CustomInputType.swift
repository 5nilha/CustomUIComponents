//  Created by Fabio Quintanilha on 4/20/20.
//  Copyright © 2020 TaskHackers. All rights reserved.
//

import Foundation

enum CustomInputType {
    case currency(LocalCurrencies)
    case percentage(LocalPercentages)
    case email
    case password
    case creditCard
    case giftCard
    case zipcode
    case custom
    
    var maxCharacters: Int {
        switch self{
        case .currency:
            return 20
        case .percentage(let localPercentage):
            switch localPercentage {
            case .regular:
                return 3
            case .oneDigitDecimal:
                return 5
            case .twoDigitsDecimal:
                return 6
            case .custom:
                return 20
            }
        case .email:
            return 256
        case .password:
            return 100
        default:
            return 256
        }
    }
    
    var titlePlaceholder: String {
        switch self {
        case .currency:
            return "Amount"
        case .percentage:
            return "Percentage"
        case .email:
            return "Email"
        case .password:
            return "Password"
        default:
            return ""
        }
    }
}
