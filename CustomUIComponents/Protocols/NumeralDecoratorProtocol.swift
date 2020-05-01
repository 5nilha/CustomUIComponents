//  Created by Fabio Quintanilha on 4/30/20.
//  Copyright © 2020 TaskHackers. All rights reserved.
//

import Foundation

protocol NumeralDecoratorProtocol{
    mutating func defaultPlaceholder() -> String
    mutating func decorate(digitChar: String?) throws -> String
    func getNumeralValue<T>(amount: T) throws -> Double?
}
