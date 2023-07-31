//
//  Created by Steven Boynes on 7/29/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

extension Subscan {
    enum Status: String, Codable {
        case ayes = "Ayes"
        case nays = "Nays"
        case abstains = "Abstains"
    }
}
