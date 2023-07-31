//
//  Created by Steven Boynes on 7/25/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

extension URLRequest {

    static func subscan(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(.apiKey, forHTTPHeaderField: "X-API-Key")
        request.timeoutInterval = 20
        return request
    }
}


#warning("Paste Subscan API key here.")
fileprivate extension String {
    static var apiKey = "XXXXXX"
}
