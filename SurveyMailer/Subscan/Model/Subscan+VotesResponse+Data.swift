//
//  Created by Steven Boynes on 7/25/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

extension Subscan.VotesResponse {
    public struct Data: Codable {
        let count: Int
        let list: [Vote]
    }
}
