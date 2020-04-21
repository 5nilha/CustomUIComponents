//  Created by Fabio Quintanilha on 4/20/20.
//  Copyright © 2020 TaskHackers. All rights reserved.
//

import Foundation

enum CustomInputType {
    case currency(Currencies)
    case percentage
    case email
    case password
    case custom
    
    var maxValue: Int {
        switch self{
        case .currency:
            return 20
        case .percentage:
            return 3
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
