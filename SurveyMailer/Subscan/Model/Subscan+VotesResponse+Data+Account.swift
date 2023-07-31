//
//  Created by Steven Boynes on 7/27/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

extension Subscan.VotesResponse.Data {
    enum Account {
        case addressOnly(AddressOnly)
        case verified(Verified)
        case child(Child)
    }
}


extension Subscan.VotesResponse.Data.Account: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let account = try? container.decode(Verified.self) {
            self = .verified(account)
        }
        else if let account = try? container.decode(Child.self) {
            self = .child(account)
        }
        else if let account = try? container.decode(AddressOnly.self) {
            self = .addressOnly(account)
        }
        else {
            let context = DecodingError.Context(codingPath: container.codingPath, debugDescription: "Failed to decode value.")
            throw DecodingError.typeMismatch(Subscan.VotesResponse.Data.Account.self, context)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .addressOnly(let account):
            try container.encode(account)
        case .verified(let account):
            try container.encode(account)
        case .child(let account):
            try container.encode(account)
        }
    }
}

extension Subscan.VotesResponse.Data.Account: CustomStringConvertible {
    public var description: String {
        switch self {
        case .addressOnly(let account):
            return String(describing: account)
        case .verified(let account):
            return String(describing: account)
        case .child(let account):
            return String(describing: account)
        }
    }
}

extension Subscan.VotesResponse.Data.Account {
    var address: Address {
        switch self {
        case .addressOnly(let account):
            return account.address
        case .verified(let account):
            return account.address
        case .child(let account):
            return account.address
        }
    }
}
