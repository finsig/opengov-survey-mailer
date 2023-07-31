//
//  Created by Steven Boynes on 7/26/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

struct Email {
    typealias Address = String
    typealias Subject = String
    typealias Body = String
    
    let toRecipients: [Address]
    let bccRecipients: [Address]
    let subject: Subject
    let body: Body
}
