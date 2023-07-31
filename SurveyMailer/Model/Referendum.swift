//
//  Created by Steven Boynes on 7/29/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

public final class Referendum: ObservableObject {
    #warning("Set Referendum number here.")
    let index: Int = 70
}


extension Referendum: CustomStringConvertible {
    public var description: String {
        return "Referendum \(index)"
    }
}
