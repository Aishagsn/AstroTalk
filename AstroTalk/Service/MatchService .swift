//
//  MatchService .swift
//  AstroTalk
//
//  Created by Aisha on 30.08.24.
//

import Foundation
import Alamofire

class MatchService {
    
    func fetchMatches(completion: @escaping (Result<[Match], Error>) -> Void) {
        NetworkManager.request(model: [Match].self,
                               endpoint: "api/user/recommendations",
                               method: .get) { matches, error in
            if let error = error {
                completion(.failure(NetworkErrorMatch.customError(error)))
            } else if let matches = matches {
                completion(.success(matches))
            } else {
                completion(.failure(NetworkErrorMatch.noData))
            }
        }
    }
    
    func fetchMatchDetail(for name: String, completion: @escaping (Result<MatchDetail, Error>) -> Void) {
        let endpoint = "api/user/\(name)"
        NetworkManager.request(model: MatchDetail.self,
                               endpoint: endpoint,
                               method: .get) { matchDetail, error in
            if let error = error {
                completion(.failure(NetworkErrorMatch.customError(error)))
            } else if let matchDetail = matchDetail {
                completion(.success(matchDetail))
            } else {
                completion(.failure(NetworkErrorMatch.noData))
            }
        }
    }
}

enum NetworkErrorMatch: Error {
    case noData
    case customError(String)
}
