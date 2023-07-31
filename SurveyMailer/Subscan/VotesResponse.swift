//
//  Created by Steven Boynes on 7/25/23.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

public struct VoteExtrinsics {
    let code: Int
    let message: String
    let generatedAt: Int
    let data: Data
}


extension VoteExtrinsics: Decodable {
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case message = "message"
        case generatedAt = "generated_at"
        case data = "data"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)
        message = try container.decode(String.self, forKey: .message)
        generatedAt = try container.decode(Int.self, forKey: .generatedAt)
        data = try container.decode(Data.self, forKey: .data)
    }
}
