//
//  LocalPercentages.swift
//  CustomUIComponents
//
//  Created by Fabio Quintanilha on 4/30/20.
//  Copyright © 2020 TaskHackers. All rights reserved.
//

import Foundation

enum LocalPercentages {
    case regular
    case oneDigitDecimal
    case twoDigitsDecimal
    case custom(NumOfDecimals: Int)
    
    func format(value: Double) -> String {
        let locale: Locale = Locale.current
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .percent
        
        switch self {
        case .regular:
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 0
            formatter.maximumIntegerDigits = 3
            formatter.minimumIntegerDigits = 1
            return formatter.string(from: NSNumber(value: value / 100))!
        case .oneDigitDecimal:
            formatter.minimumFractionDigits = 1
            formatter.maximumFractionDigits = 1
            formatter.maximumIntegerDigits = 3
            formatter.minimumIntegerDigits = 1
            return formatter.string(from: NSNumber(value: value / 100))!
        case .twoDigitsDecimal:
            formatter.minimumFractionDigits = 1
            formatter.maximumFractionDigits = 2
            formatter.maximumIntegerDigits = 3
            formatter.minimumIntegerDigits = 1
            return formatter.string(from: NSNumber(value: value / 100))!
        case .custom(let decimals):
            formatter.minimumFractionDigits = 1
            formatter.maximumFractionDigits = decimals
            formatter.minimumIntegerDigits = 1
            return formatter.string(from: NSNumber(value: value / 100))!
        }
    }
}
