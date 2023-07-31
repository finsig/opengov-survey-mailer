//
//  Created by Steven Boynes on 7/30/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

extension Subscan {
    struct Account: Identifiable {
        let id: Address
        let email: Email.Address
        let display: String?
    }
}


extension Subscan.Account: Hashable {
    static func == (lhs: Subscan.Account, rhs: Subscan.Account) -> Bool {
        lhs.email.caseInsensitiveCompare(rhs.email) == .orderedSame
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(email)
    }
}


extension Subscan.Account: CustomStringConvertible {
    var description: String {
        return "[ \(id) | \(String(describing: display)) | \(email) ]"
    }
}
