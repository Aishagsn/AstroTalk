//
//  ProfileService.swift
//  AstroTalk
//
//  Created by Aisha on 28.09.24.
//

import Foundation
import Alamofire

class ProfileService {
    
    func fetchUserProfile(completion: @escaping (User?, String?) -> Void) {
        NetworkManager.request(model: User.self, endpoint: "/user/profile", method: .get) { user, error in
            if let error = error {
                print("Error fetching user profile: \(error)")
                completion(nil, error)
                return
            }
            completion(user, nil)
        }
    }

    func fetchUserDetails(completion: @escaping (UserDetails?, String?) -> Void) {
        NetworkManager.request(model: UserDetails.self, endpoint: "/user/details", method: .get) { userDetails, error in
            if let error = error {
                print("Error fetching user details: \(error)")
                completion(nil, error)
                return
            }
            completion(userDetails, nil)
        }
    }
    
    func followUser(userToFollowId: Int, completion: @escaping (String?) -> Void) {
        let parameters: [String: Any] = ["userId": userToFollowId]
        NetworkManager.request(model: User.self, endpoint: "/user/follow", method: .post, parameters: parameters, isEncodingNeeded: true) { _, error in
            completion(error)
        }
    }

    func unfollowUser(userToUnfollowId: Int, completion: @escaping (String?) -> Void) {
        let parameters: [String: Any] = ["userId": userToUnfollowId]
        NetworkManager.request(model: User.self, endpoint: "/user/unfollow", method: .post, parameters: parameters, isEncodingNeeded: true) { _, error in
            completion(error)
        }
    }
    
    func fetchFollowersCount(completion: @escaping (Int?, String?) -> Void) {
        NetworkManager.request(model: Int.self, endpoint: "/user/followers/count", method: .get) { count, error in
            completion(count, error)
        }
    }

    func fetchFollowingCount(completion: @escaping (Int?, String?) -> Void) {
        NetworkManager.request(model: Int.self, endpoint: "/user/following/count", method: .get) { count, error in
            completion(count, error)
        }
    }
}
