//
//  Created by Steven Boynes on 7/29/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

extension Subscan {
    enum Valid: String {
        case valid
        case invalid
    }
}

extension Subscan.Valid: Codable {}
