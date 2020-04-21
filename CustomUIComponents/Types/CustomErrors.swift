//  Created by Fabio Quintanilha on 4/20/20.
//  Copyright © 2020 TaskHackers. All rights reserved.

import Foundation

enum CustomEntryError: Error {
    case invalidInput
    case unknown
    
    var description: String {
        switch self {
        case .invalidInput:
            return "The input entered is invalid"
        case .unknown:
            return localizedDescription
        }
    }
}
