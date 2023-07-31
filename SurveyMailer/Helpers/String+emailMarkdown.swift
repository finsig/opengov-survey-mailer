//
//  Created by Steven Boynes on 7/29/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

extension String {
    static var emailMarkdown = try! String(contentsOf: .emailMarkdown)
}


fileprivate extension URL {
    static var emailMarkdown = Bundle.main.url(forResource: "email", withExtension: "md")!
}
