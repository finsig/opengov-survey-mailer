//
//  Created by Steven Boynes on 7/25/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import SwiftUI
import SwiftData
import MessageUI

struct VoterAccountsView: View {
    
    @EnvironmentObject var referendum: Referendum
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject private var subscan = Subscan()
    
    @State private var votes = [Vote]()
    @State private var email = Email(toRecipients: [Address](), bccRecipients: [Address](), subject: "", body: "")
    @State private var isShowingMailComposeView = false
    @State private var resultForMailCompose: Result<MFMailComposeResult, Error>? = nil
    
    @State private var valid: Subscan.Valid = .valid
    @State private var status: Subscan.Status = .nays
    
    @State private var visibleAccounts = [Subscan.Account]()
    
    var body: some View {
        VStack {
            
            ProgressView("Fetching voter acounts...", value: subscan.progress, total: .total)
                .padding([.leading, .trailing, .top], 40)
         
            List{
                Section {
                    ForEach(visibleAccounts, id: \.self) { account in
                        HStack{
                            Text( display(account) )
                            Spacer()
                            Image(systemName: "envelope")
                                .foregroundColor(.polkadotGreen)
                        }
                    }
                } header: {
                    Text("On-chain identity")
                  
                } footer: {
                    if subscan.accounts.count >= .visibleAccounts {
                        HStack {
                            if !subscan.isDone {
                                ProgressView()
                                    .padding(.trailing, 5)
                            }
                            Text("\(subscan.accounts.count) \(String(describing: status)) voter accounts")
                        }
                    }
                }
            }
            .onChange(of: subscan.accounts) {
                visibleAccounts = Array( subscan.accounts.suffix(.visibleAccounts) )
            }
            .padding()

            if subscan.isDone {
                Button {
                    isShowingMailComposeView = true
                } label: {
                    Text("Compose Email")
                        .padding()
                        .foregroundColor(.polkadotCyan)
                        .background(
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .stroke(.polkadotCyan, lineWidth: 2)
                        )
                }
                .padding()
                Spacer()
            }
        }
        .padding()
        .onAppear(perform: {
            subscan.fetchVotes(referendum: referendum)
        })
        .onChange(of: subscan.isFetchVotesDone) {
            let nayVotes = subscan.votes.filter({
                ($0.valid == true) && ($0.status == Subscan.Status.nays)
            })
            subscan.fetchAccounts(votes: nayVotes)
            
            votes = nayVotes.map({
                Vote(vote: $0)
            })
        }
        .onChange(of: subscan.isDone) {
            for account in subscan.accounts {
                print(String(describing: account))
            }
            #warning("Enable BCC recipient addresses here.")
            //email = Email(bccRecipients: subscan.accounts.map({ $0.email }))
            email = Email(bccRecipients: [Address]())
        }
        .sheet(isPresented: $isShowingMailComposeView){
            if MFMailComposeViewController.canSendMail() {
                MailComposeView(email: $email, isShowing: $isShowingMailComposeView, result: $resultForMailCompose)
            }
            else {
                Text("There are no Email accounts configured. You can add or create an Email account in the Settings app.")
            }
        }
        .interactiveDismissDisabled(!subscan.isDone)
        .onChange(of: isShowingMailComposeView) {
            guard isShowingMailComposeView == false else {
                return
            }
            dismiss()
        }
    }
}
    

fileprivate extension Email {
    init(bccRecipients recipients: [Address]) {
        toRecipients = ["hello@finsig.io"]
        bccRecipients = Array( Set(recipients) )
        subject = "OpenGov Referendum Voter Survey"
        body = .emailMarkdown
    }
}

extension Subscan.Status: CustomStringConvertible {
    var description: String {
        switch self {
        case .ayes:
            return "Aye"
        case .nays:
            return "Nay"
        case .abstains:
            return "Abstain"
        }
    }
}

fileprivate extension VoterAccountsView {
    func display(_ account: Subscan.Account) -> String {
        guard let display = account.display else {
            return account.id
        }
        return display
    }
}

fileprivate extension Int {
    static let visibleAccounts = 8
}
