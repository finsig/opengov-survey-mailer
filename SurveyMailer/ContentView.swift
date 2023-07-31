//
//  Created by Steven Boynes on 7/25/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var referendum: Referendum
    
    @State private var isShowingMailPreparationSheet = false
    
    var body: some View {
        
        NavigationSplitView {
            List {
                NavigationLink("Votes", value: Link.votes)
                NavigationLink("View Email Markdown", value: Link.viewEmailMarkdown)
 
                Button {
                    isShowingMailPreparationSheet = true
                } label: {
                    Text("Compose Email")
                }
                .sheet(isPresented: $isShowingMailPreparationSheet){
                    VoterAccountsView()
                }
            }
            .listStyle(.sidebar)
            .navigationTitle( String(describing: referendum) )
            .navigationDestination(for: Link.self) {
                switch $0 {
                case .votes:
                    VoteTableView()
                case .viewEmailMarkdown:
                    MarkdownView()
                }
            }
        } detail: {
            VoteTableView()
        }
    }
}


fileprivate enum Link: Int {
    case votes
    case viewEmailMarkdown
}
