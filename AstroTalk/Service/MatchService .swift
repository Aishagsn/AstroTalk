//
//  MatchService .swift
//  AstroTalk
//
//  Created by Aisha on 30.08.24.
//

import Foundation
import Alamofire

class MatchService {
    
    func fetchMatches(completion: @escaping ([Match]?, String?) -> Void) {
        NetworkManager.request(model: [Match].self, endpoint: "matches") { response, error in
            if let error = error {
                print("Failed to fetch matches: \(error)")
                completion(nil, error)
            } else if let matches = response {
                completion(matches, nil)
            }
        }
    }

    func fetchMatchDetail(for name: String, completion: @escaping (MatchDetail?, String?) -> Void) {
        let endpoint = "matches/\(name)"
        NetworkManager.request(model: MatchDetail.self, endpoint: endpoint) { response, error in
            if let error = error {
                print("Failed to fetch match detail: \(error)")
                completion(nil, error)
            } else if let matchDetail = response {
                completion(matchDetail, nil)
            }
        }
    }
}
