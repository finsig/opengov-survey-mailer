//
//  Created by Steven Boynes on 7/25/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

extension Subscan.SearchResponse.Data.Account {
    struct Proxy {
        let proxyAccounts: [ProxyAccount]?
    }
}


extension Subscan.SearchResponse.Data.Account.Proxy: Codable {
    enum CodingKeys: String, CodingKey {
        case proxyAccounts = "proxy_account"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        proxyAccounts = try container.decodeIfPresent([ProxyAccount].self, forKey: .proxyAccounts)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(proxyAccounts, forKey: .proxyAccounts)
    }
}
