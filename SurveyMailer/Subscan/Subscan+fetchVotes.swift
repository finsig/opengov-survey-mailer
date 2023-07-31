//
//  Created by Steven Boynes on 7/29/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation
import SwiftData

extension Subscan {
    func fetchVotes(referendum: Referendum, valid: Valid? = nil, status: Status? = nil, page: Int = .zero) {
        
        var request = URLRequest.subscan(url: .referendaVotes)
        
        let payload = VotesRequest(referendum: referendum, valid: valid, status: status, page: page, row: .maximumRowsAllowed)
        request.httpBody = try! JSONEncoder().encode(payload)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data else {
                return
            }
            //print(data: data, options: .prettyPrinted)
            
            do {
                let votesResponse = try JSONDecoder().decode(VotesResponse.self, from: data)
                
                self.votes.append(contentsOf: votesResponse.data.list)
   
                if votesResponse.resultCount < .maximumRowsAllowed {
                    DispatchQueue.main.async {
                        self.isFetchVotesDone = true
                    }
                }
                else {
                    self.fetchVotes(referendum: referendum, valid: valid, status: status, page: page + 1)
                }
    
            } catch {
                print(error)
            }
            
       }.resume()
    }
}


fileprivate extension Int {
    static let maximumRowsAllowed = 100
}

fileprivate extension Subscan.VotesResponse {
    var resultCount: Int {
        return data.list.count
    }
}
