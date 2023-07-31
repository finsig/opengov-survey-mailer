//
//  Created by Steven Boynes on 7/30/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

extension Subscan.SearchResponse.Data.Account {
    struct AccountDisplay: Codable {
        let address: Address
        let display: String?
    }
}
