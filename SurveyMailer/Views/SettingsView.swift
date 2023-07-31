//
//  Created by Steven Boynes on 7/25/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import SwiftUI

struct MarkdownView: View {
    
    var body: some View {
        Text(.emailMarkdown)
            .padding(40)
    }
}


fileprivate extension LocalizedStringKey {
    static var emailMarkdown = LocalizedStringKey(.emailMarkdown)
}
