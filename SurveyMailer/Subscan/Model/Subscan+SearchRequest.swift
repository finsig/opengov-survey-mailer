//
//  Created by Steven Boynes on 7/25/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

extension Subscan {
    public struct SearchRequest {
        let key: Address
        
        init(key: Address) {
            self.key = key
        }
    }
}


extension Subscan.SearchRequest: Encodable {
    enum CodingKeys: String, CodingKey {
        case key = "key"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(key, forKey: .key)
    }
}
