//
//  Created by Steven Boynes on 7/25/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

extension Subscan.SearchResponse.Data.Account.Proxy.ProxyAccount {
    struct AccountDisplay: Codable {
        let display: String?
        let address: Address
    }
}
