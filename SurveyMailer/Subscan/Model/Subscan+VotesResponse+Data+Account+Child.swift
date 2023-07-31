//
//  Created by Steven Boynes on 7/27/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

extension Subscan.VotesResponse.Data.Account {
    struct Child: AccountId, Codable {
        let address: Address
        let parent: Parent
    }
}


struct Parent: Codable {
    //let identity: Bool
    let display: String
    //let subSymbol: String
    let address: Address
}

extension Subscan.VotesResponse.Data.Account.Child: CustomStringConvertible {
    var description: String {
        return parent.display
    }
}
