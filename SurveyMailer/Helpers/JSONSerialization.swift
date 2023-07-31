//
//  Created by Steven Boynes on 7/27/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

func print(data: Data, options: JSONSerialization.WritingOptions) {
    print("start json")
    if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
       let jsonData = try? JSONSerialization.data(withJSONObject: json, options: options) {
        print(String(decoding: jsonData, as: UTF8.self))
    } else {
        print("json data malformed")
    }
    print("end json")
}
