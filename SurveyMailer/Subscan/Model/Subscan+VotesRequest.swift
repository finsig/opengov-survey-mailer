//
//  Created by Steven Boynes on 7/25/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

extension Subscan {
    public struct VotesRequest {
        let referendumIndex: Int
        let sort: Sort?
        let order: Order?
        let valid: Valid?
        let status: Status?
        let page: Int?
        let row: Int
        
        init(referendum: Referendum, sort: Sort? = nil, order: Order? = nil, valid: Valid? = nil, status: Status? = nil, page: Int? = nil, row: Int) {
            self.referendumIndex = referendum.index
            self.sort = sort
            self.order = order
            self.valid = valid
            self.status = status
            self.page = page
            self.row = row
        }
    }
}

extension Subscan.VotesRequest: Encodable {
    enum CodingKeys: String, CodingKey {
        case referendumIndex = "referendum_index"
        case sort = "sort"
        case order = "order"
        case valid = "valid"
        case status = "status"
        case page = "page"
        case row = "row"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(referendumIndex, forKey: .referendumIndex)
        try container.encodeIfPresent(sort, forKey: .sort)
        try container.encodeIfPresent(order, forKey: .order)
        try container.encodeIfPresent(valid, forKey: .valid)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(page, forKey: .page)
        try container.encode(row, forKey: .row)
    }
}
