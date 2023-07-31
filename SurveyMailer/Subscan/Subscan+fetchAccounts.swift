//
//  Created by Steven Boynes on 7/29/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

extension Subscan {
    
    func fetchAccounts(votes: [VotesResponse.Data.Vote], index: Int = .zero) {
        guard votes.indices.contains(index) else {
            return
        }
        let vote = votes[index]
       
        switch vote.account {
        case .child(let child):
            fetchEmailAddress(child: child)
        default:
            break
        }

        var request = URLRequest.subscan(url: .accountSearch)
        let address = vote.account.address
        let payload = SearchRequest(key: address)
        request.httpBody = try! JSONEncoder().encode(payload)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data else {
                return
            }
            //print(data: data, options: .prettyPrinted)
            
            self.receivedResponse.append(true)
            
            do {
                let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                
                if let account = Account(searchResponse) {
                    if self.accounts.contains(account) == false {
                        DispatchQueue.main.async {
                            self.accounts.append(account)
                        }
                    }
                }
                else {
                    if let proxyAccounts = searchResponse.data.account.proxy?.proxyAccounts {
                        if proxyAccounts.isEmpty == false {
                            self.fetchAccounts(proxyAccounts: proxyAccounts)
                        }
                    }
                }
            } catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                self.progress = Progress(self.receivedResponse.count) / Progress(votes.count)
                self.isDone = (self.progress == Progress.total)
            }
            self.fetchAccounts(votes: votes, index: index + 1)
            
        }.resume()
         
    }
}


extension Subscan {
    func fetchAccounts(proxyAccounts: [Subscan.SearchResponse.Data.Account.Proxy.ProxyAccount]) {
        let addresses = proxyAccounts.map({ $0.accountDisplay.address })
        for address in addresses  {
            self.fetchEmailAddress(account: address)
        }
    }
    
    func fetchEmailAddress(account address: Address) {
        var request = URLRequest.subscan(url: .accountSearch)
        let payload = SearchRequest(key: address)
        request.httpBody = try! JSONEncoder().encode(payload)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data else {
                return
            }
            do {
                let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                
                if let account = Account(searchResponse) {
                    if self.accounts.contains(account) == false {
                        DispatchQueue.main.async {
                            self.accounts.append(account)
                        }
                    }
                }
                
            } catch {
                print(error)
            }
        }.resume()
    }
}

extension Subscan {
    func fetchEmailAddress(child: VotesResponse.Data.Account.Child) {
        let key = child.parent.address
        var request = URLRequest.subscan(url: .accountSearch)
        let payload = SearchRequest(key: key)
        request.httpBody = try! JSONEncoder().encode(payload)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data else {
                return
            }
            //print(data: data, options: .prettyPrinted)
            
            do {
                let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                
                if let account = Account(searchResponse) {
                    let newAccount = Account(id: child.address, email: account.email, display: account.display)
                    DispatchQueue.main.async {
                        self.accounts.append(newAccount)
                    }
                }
            } catch {
                print(error)
            }
        }.resume()
         
    }
}

fileprivate extension Subscan.Account {
    init?(_ response: Subscan.SearchResponse) {
        let id = response.data.account.address
        guard let email = response.data.account.email else {
            return nil
        }
        guard email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false else {
            return nil
        }
        let display = response.data.account.display
        
        self.init(id: id, email: email, display: display)
    }
}
