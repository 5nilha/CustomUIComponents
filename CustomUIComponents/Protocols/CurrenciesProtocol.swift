//  Created by Fabio Quintanilha on 4/18/20.
//  Copyright © 2020 TaskHackers. All rights reserved.

import Foundation

protocol CurrenciesProtocol {
    var symbol: String { get }
    var code: String { get }
    var unit: String { get }
    var plural: String { get }
    var currencyNumber: String { get }
    var decimalSeparator: String { get }
}
