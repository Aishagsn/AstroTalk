//
//  MatchDetailViewModel.swift
//  AstroTalk
//
//  Created by Aisha on 30.08.24.
//

import Foundation

class MatchDetailViewModel {
    private let matchService = MatchService()
    var matchDetail: MatchDetail
    private(set) var isFollowing: Bool = false
    
    init(matchDetail: MatchDetail) {
            self.matchDetail = matchDetail
        }


    func fetchMatchDetail(for name: String, completion: @escaping (MatchDetail?, String?) -> Void) {
            matchService.fetchMatchDetail(for: name) { [weak self] matchDetail, errorMessage in
                if let error = errorMessage {
                    completion(nil, error)
                } else if let matchDetail = matchDetail {
                    self?.matchDetail = matchDetail
                    completion(matchDetail, nil)
                } else {
                    completion(nil, "Unknown error occurred.")
                }
            }
        }
    func followUser(completion: @escaping (Bool, Error?) -> Void) {
           isFollowing.toggle()
           
           let action = isFollowing ? "followed" : "unfollowed"
           let message = "\(matchDetail.name) has been \(action)."
           
           // Simulate network request or action
           DispatchQueue.global().async {
               sleep(1) // Simulate network delay
               
               DispatchQueue.main.async {
                   print(message)
                   completion(true, nil) // Notify success
               }
           }
        let success = true // Simulate success/failure
                if success {
                    completion(true, nil)
                } else {
                    let errorMessage = "Failed to follow user." // Replace with actual error message
                    completion(false, errorMessage as? Error)
                }
       }
   }
