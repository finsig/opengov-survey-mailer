//
//  Created by Steven Boynes on 7/25/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation
import SwiftData

@Model
final class Vote {
    
    var address: Address
    var amount: Int
    var conviction: Float
    var status: String /// note: possible Swift 5.9 bug, Status enum type fails in predicate
    var valid: Bool
    
    @Attribute(.unique) var extrinsicIndex: String 
    
    var votingTime: Int
    var display: String

    init(address: Address, amount: Int, conviction: Float, status: String, valid: Bool, extrinsicIndex: String,votingTime: Int, display: String) {
        self.address = address
        self.amount = amount
        self.conviction = conviction
        self.status = status
        self.valid = valid
        self.extrinsicIndex = extrinsicIndex
        self.votingTime = votingTime
        self.display = display
    }
}

extension Vote: Identifiable {}

extension Vote: Hashable {
    static func == (lhs: Vote, rhs: Vote) -> Bool {
        lhs.extrinsicIndex == rhs.extrinsicIndex
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(extrinsicIndex)
    }
}
