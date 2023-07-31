//
//  Created by Steven Boynes on 7/29/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

public final class Subscan: ObservableObject {
    @Published var progress: Progress = .zero
    @Published var isDone: Bool = false
    @Published var isFetchVotesDone: Bool = false
    
    internal var receivedResponse = [Bool]()
    
    var votes = [VotesResponse.Data.Vote]()
    
    @Published var accounts = [Account]()
    
    var requestQueue = [URLSessionTask]()
}
