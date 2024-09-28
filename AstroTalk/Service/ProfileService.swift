//
//  ProfileService.swift
//  AstroTalk
//
//  Created by Aisha on 28.09.24.
//

import Foundation
import Alamofire

class ProfileService {
    let baseURL = "http://34.28.199.212:8088/api/user"

    func fetchUserProfile(completion: @escaping (UserProfile?, Error?) -> Void) {
        let endpoint = "/me"
        NetworkManager.request(model: UserProfile.self, endpoint: endpoint, method: .get) { (profile: UserProfile?, error: String?) in
            completion(profile, error != nil ? NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: error!]) : nil)
        }
    }

    func followUser(userToFollowId: Int, completion: @escaping (Error?) -> Void) {
        let endpoint = "/follow/\(userToFollowId)"
        NetworkManager.request(model: EmptyResponse.self, endpoint: endpoint, method: .post) { (_, error: String?) in
            completion(error != nil ? NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: error!]) : nil)
        }
    }

    func unfollowUser(userToUnfollowId: Int, completion: @escaping (Error?) -> Void) {
        let endpoint = "/unfollow/\(userToUnfollowId)"
        NetworkManager.request(model: EmptyResponse.self, endpoint: endpoint, method: .post) { (_, error: String?) in
            completion(error != nil ? NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: error!]) : nil)
        }
    }

    func fetchFollowersCount(completion: @escaping (Int?, Error?) -> Void) {
        let endpoint = "/followersCount"
        NetworkManager.request(model: Int.self, endpoint: endpoint, method: .get) { (count: Int?, error: String?) in
            completion(count, error != nil ? NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: error!]) : nil)
        }
    }

    func fetchFollowingCount(completion: @escaping (Int?, Error?) -> Void) {
        let endpoint = "/followingCount"
        NetworkManager.request(model: Int.self, endpoint: endpoint, method: .get) { (count: Int?, error: String?) in
            completion(count, error != nil ? NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: error!]) : nil)
        }
    }
}

struct EmptyResponse: Codable {}
