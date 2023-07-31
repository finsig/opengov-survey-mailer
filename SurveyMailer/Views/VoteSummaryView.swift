//
//  Created by Steven Boynes on 7/30/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import SwiftUI

struct VoteSummaryView: View {
    @Binding var votes: [Vote]
    @ObservedObject var subscan: Subscan
    
    var body: some View {
        HStack{
            if !subscan.isFetchVotesDone {
                ProgressView()
                    .padding(.trailing, 5)
            }
            Text("\(votes.count) votes")
                .font(.footnote)
                .foregroundStyle(.secondary)
            Spacer()
        }
    }
}
