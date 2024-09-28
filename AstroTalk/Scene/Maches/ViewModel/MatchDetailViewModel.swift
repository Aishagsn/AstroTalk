//
//  MatchDetailViewModel.swift
//  AstroTalk
//
//  Created by Aisha on 30.08.24.
//

import Foundation

class MatchDetailViewModel {
    private let matchService = MatchService()
    var matchDetail: MatchDetail?
    private(set) var isFollowing: Bool = false
    var match: [Match] = []
    

    func fetchMatchDetail(for name: String, completion: @escaping (MatchDetail?, String?) -> Void) {
        matchService.fetchMatchDetail(for: name) { [weak self] result in
            switch result {
            case .success(let matchDetail):
                self?.matchDetail = matchDetail
                completion(matchDetail, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }

    func followUser(completion: @escaping (Bool, Error?) -> Void) {
        isFollowing.toggle()
        
        let action = isFollowing ? "followed" : "unfollowed"
        let message = "\(matchDetail?.name ?? "") has been \(action)."
        
        DispatchQueue.global().async {
            sleep(1)
            
            DispatchQueue.main.async {
                print(message)
                completion(true, nil)
            }
        }
    }
}
