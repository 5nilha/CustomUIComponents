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
    case decimal

    func format(value: Double) -> String {
        print("Value \(value)")
        let locale: Locale = Locale.current
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .percent
        
        switch self {
        case .regular:
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 0
            return formatter.string(from: NSNumber(value: value / 100))!
        case .decimal:
            formatter.minimumFractionDigits = 1
            formatter.maximumFractionDigits = 1
            formatter.maximumIntegerDigits = 3
            formatter.minimumIntegerDigits = 1
            return formatter.string(from: NSNumber(value: value / 100))!
            
            
//            formatter.numberStyle = .decimal
//            let decimalPercent = "\(formatter.string(from: NSNumber(value: value))!) \(formatter.percentSymbol!)"
//
//            return decimalPercent
            
        }
    }
}
