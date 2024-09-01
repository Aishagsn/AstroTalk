//
//  MatchService .swift
//  AstroTalk
//
//  Created by Aisha on 30.08.24.
//

import Foundation

class MatchService {
    func fetchMatches(completion: @escaping ([Match]) -> Void) {
        let urlString = "http://fakeapi.com/matches"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let matches = try decoder.decode([Match].self, from: data)
                    completion(matches)
                } catch {
                    print("Failed to decode JSON")
                }
            }
        }.resume()
    }

    func fetchMatchDetail(for name: String, completion: @escaping (MatchDetail) -> Void) {
        let urlString = "http://fakeapi.com/matches/\(name)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let matchDetail = try decoder.decode(MatchDetail.self, from: data)
                    completion(matchDetail)
                } catch {
                    print("Failed to decode JSON")
                }
            }
        }.resume()
    }
}
