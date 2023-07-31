//
//  Created by Steven Boynes on 7/25/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

extension Subscan {
    public struct SearchResponse {
        let code: Int
        let message: String
        let generatedAt: Int
        let data: Data
    }
}


extension Subscan.SearchResponse: Codable {
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
     
     public func encode(to encoder: Encoder) throws {
         var container = encoder.container(keyedBy: CodingKeys.self)
         try container.encode(code, forKey: .code)
         try container.encode(message, forKey: .message)
         try container.encode(generatedAt, forKey: .generatedAt)
         try container.encode(data, forKey: .data)
     }
 }
