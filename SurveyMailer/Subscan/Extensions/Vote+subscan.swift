//
//  Created by Steven Boynes on 7/29/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

extension Vote {
    convenience init(vote: Subscan.VotesResponse.Data.Vote) {
        let address = vote.account.address
        let amount = Int(vote.amount)!
        let conviction = Float(vote.conviction)!
        //let votes = Int(vote.votes)!
        let status = vote.status.rawValue
        let valid = Bool(vote.valid)
        let extrinsicIndex = vote.extrinsicIndex
        let votingTime = vote.votingTime
        let display = String(describing: vote.account)
        self.init(address: address, amount: amount, conviction: conviction, status: status, valid: valid, extrinsicIndex: extrinsicIndex, votingTime: votingTime, display: display)
    }
}


fileprivate extension Bool {
    init(_ valid: Subscan.Valid) {
        self = (valid == .valid)
    }
}
