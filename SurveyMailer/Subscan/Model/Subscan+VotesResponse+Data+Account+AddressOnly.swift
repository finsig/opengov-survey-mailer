//
//  Created by Steven Boynes on 7/27/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

extension Subscan.VotesResponse.Data.Account {
    struct AddressOnly: AccountId, Codable {
        let address: Address
    }
}


extension Subscan.VotesResponse.Data.Account.AddressOnly: CustomStringConvertible {
    var description: String {
        return address.abbreviated
    }
}
