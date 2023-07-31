//
//  Created by Steven Boynes on 7/27/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

extension String {
    var abbreviated: String {
        return self.prefix(6) + "..." + self.suffix(6)
    }
}
