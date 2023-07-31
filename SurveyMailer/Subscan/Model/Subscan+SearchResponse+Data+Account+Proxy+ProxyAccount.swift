//
//  Created by Steven Boynes on 7/28/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

extension Subscan.SearchResponse.Data.Account.Proxy {
    struct ProxyAccount {
        let accountDisplay: AccountDisplay
        let proxyType: ProxyType
    }
}

extension Subscan.SearchResponse.Data.Account.Proxy.ProxyAccount: Codable {
    enum CodingKeys: String, CodingKey {
        case accountDisplay = "account_display"
        case proxyType = "proxy_type"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        accountDisplay = try container.decode(AccountDisplay.self, forKey: .accountDisplay)
        proxyType = try container.decode(ProxyType.self, forKey: .proxyType)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(accountDisplay, forKey: .accountDisplay)
        try container.encode(proxyType, forKey: .proxyType)
    }
}


