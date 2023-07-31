//
//  Created by Steven Boynes on 7/25/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

extension Subscan.SearchResponse.Data {
    struct Account: Codable {
        let address: Address
        let email: Email.Address?
        let proxy: Proxy?
        let accountDisplay: AccountDisplay?
        let parent: Parent?
        let display: String?
    }
}
