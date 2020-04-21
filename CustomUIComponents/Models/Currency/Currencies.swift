//  Created by Fabio Quintanilha on 4/18/20.
//  Copyright © 2020 TaskHackers. All rights reserved.

import Foundation

enum Currencies {
    case GBP(_GBP)
    case EUR(_EUR)
    case USD(_USD)
    case BRL(_BRL)
    case Localized
    
    enum _GBP {
        case en
        
        var locale:  Locale {
            switch self {
            case .en:
                return Locale(identifier: "en-GB")
            }
        }
    }
    
    enum _EUR {
        case en
        case fr
        
        var locale:  Locale {
            switch self {
            case .en:
                return Locale(identifier: "en-FR")
            case .fr:
                return Locale(identifier: "fr-FR")
            }
        }
    }
    
    enum _USD {
        case en
        case es
        
        var locale:  Locale {
            switch self {
            case .en:
                return Locale(identifier: "en-US")
            case .es:
                return Locale(identifier: "es-PR")
            }
        }
    }
    
    enum _BRL {
        case pt
        
        var locale:  Locale {
            switch self {
            case .pt:
                return Locale(identifier: "pt-BR")
            }
        }
    }
    
    func format(value: Double) -> String {
        var locale: Locale!
        switch self {
        case .GBP(let languageLocale):
            locale = languageLocale.locale
        case .EUR(let languageLocale):
            locale = languageLocale.locale
        case .USD(let languageLocale):
            locale = languageLocale.locale
        case .BRL(let languageLocale):
            locale = languageLocale.locale
        case .Localized:
            locale = Locale.current
        }
            
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .currencyAccounting
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: value))!
    }
}
