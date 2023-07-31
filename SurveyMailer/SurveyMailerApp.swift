//
//  Created by Steven Boynes on 7/25/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import SwiftUI
import SwiftData

@main
struct SurveyMailerApp: App {
    
    @StateObject var referendum = Referendum()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(referendum)
                .modelContainer(for: [Vote.self])
        }
    }
}
