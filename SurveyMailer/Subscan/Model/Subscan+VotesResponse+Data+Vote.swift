//
//  Created by Steven Boynes on 7/27/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

extension Subscan.VotesResponse.Data {
    public struct Vote {
        let account: Account
        let amount: String
        let status: Subscan.Status
        let delegateAccount: Account?
        let extrinsicIndex: String
        let votes: String
        let valid: Valid
        let votingTime: Int
        let conviction: String
    }
}


extension Subscan.VotesResponse.Data.Vote: Codable {
    enum CodingKeys: String, CodingKey {
        case account = "account"
        case amount = "amount"
        case status = "status"
        case delegateAccount = "delegate_account"
        case extrinsicIndex = "extrinsic_index"
        case votes = "votes"
        case valid = "valid"
        case votingTime = "voting_time"
        case conviction = "conviction"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        account = try container.decode(Subscan.VotesResponse.Data.Account.self, forKey: .account)
        amount = try container.decode(String.self, forKey: .amount)
        status = try container.decode(Subscan.Status.self, forKey: .status)
        delegateAccount = try container.decodeIfPresent(Subscan.VotesResponse.Data.Account.self, forKey: .delegateAccount)
        extrinsicIndex = try container.decode(String.self, forKey: .extrinsicIndex)
        votes = try container.decode(String.self, forKey: .votes)
        valid = try container.decode(Valid.self, forKey: .valid)
        votingTime = try container.decode(Int.self, forKey: .votingTime)
        conviction = try container.decode(String.self, forKey: .conviction)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(account, forKey: .account)
        try container.encode(amount, forKey: .amount)
        try container.encode(status, forKey: .status)
        try container.encodeIfPresent(delegateAccount, forKey: .delegateAccount)
        try container.encode(extrinsicIndex, forKey: .extrinsicIndex)
        try container.encode(votes, forKey: .votes)
        try container.encode(valid, forKey: .valid)
        try container.encode(votingTime, forKey: .votingTime)
        try container.encode(conviction, forKey: .conviction)
    }
}
