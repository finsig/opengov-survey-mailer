//
//  Created by Steven Boynes on 7/25/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import SwiftUI
import SwiftData

struct VoteTableView: View {
    
    @EnvironmentObject var referendum: Referendum
    
    @ObservedObject private var subscan = Subscan()
    
    @State private var votes = [Vote]()
    @State private var valid: Subscan.Valid = .valid
    @State private var status: Subscan.Status = .nays
    
    var body: some View {
        Table(votes) {
            TableColumn("Account", value: \.display)
            TableColumn("Value", value: \.value)
            TableColumn("Conviction", value: \.convictionWeight)
            TableColumn("Effective Votes", value: \.effectiveVotes)
            TableColumn("Extrinsic ID", value: \.extrinsicIndex)
            TableColumn("Date", value: \.formattedDate)
            TableColumn("Voted", value: \.voted)
        }
        .onAppear(perform: {
            subscan.fetchVotes(referendum: referendum, valid: valid, status: status)
        })
        .onChange(of: subscan.isFetchVotesDone) {
            votes = subscan.votes.map({
                Vote(vote: $0)
            })
        }
        
        VoteSummaryView(votes: $votes, subscan: subscan)
            .padding()
    }
}


extension Vote {
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }

    var date: Date {
        return Date(timeIntervalSince1970: Double(votingTime))
    }
    
    var value: String {
        let dot: Double = Double(amount) / Double.oneDOT
        let result = dot.rounded(.towardZero)
        let formatted = result.formatted(.number.precision(.fractionLength(.zero)))
        return formatted + " DOT"
    }
    
    var convictionWeight: String {
        if conviction == Float(0.1) {
            return String(format: "%.1f", conviction) + "x"
        }
        else {
            return String(format: "%.0f", conviction) + "x"
        }
    }
    
    var effectiveVotes: String {
        let votes: Double = Double(amount) * Double(conviction)
        let dot: Double = votes / Double.oneDOT
        let result = dot.rounded(.towardZero)
        let formatted = result.formatted(.number.precision(.fractionLength(.zero)))
        return formatted
    }
    
    var voted: String { /// note: workaround for Status enum issue when using Swift 5.9 and SwiftData
        if status.caseInsensitiveCompare("Ayes") == .orderedSame {
            return "Aye"
        }
        else if status.caseInsensitiveCompare("Nays") == .orderedSame {
            return "Nay"
        }
        else if status.caseInsensitiveCompare("Abstains") == .orderedSame {
            return "Abstain"
        }
        else {
            return .empty
        }
    }
}

fileprivate extension Double {
    static let oneDOT = Double(10000000000) /// 10,000,000,000
}
