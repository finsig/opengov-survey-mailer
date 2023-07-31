//
//  Created by Steven Boynes on 7/27/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

extension Subscan.VotesResponse.Data.Account {
    struct Verified: AccountId, Codable {
        let address: Address
        //let judgements: Judgements
        //let identity: Bool
        let display: String
        //let accountIndex: String
    }
}


extension Subscan.VotesResponse.Data.Account.Verified: CustomStringConvertible {
    var description: String {
        return display
    }
}
