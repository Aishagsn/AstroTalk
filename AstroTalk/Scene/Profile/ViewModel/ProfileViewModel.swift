//
//  ProfileViewModel.swift
//  AstroTalk
//
//  Created by Aisha on 28.09.24.
//

import Foundation

class ProfileViewModel {
    
    var userProfile: User?
    var userDetails: UserDetails?
    private let profileService = ProfileService()
    private(set) var userId: Int?

    func fetchUserProfile(completion: @escaping (Bool) -> Void) {
        profileService.fetchUserProfile { [weak self] profile, error in
            if let error = error {
                print("Error fetching profile: \(error)")
                completion(false)
                return
            }

            self?.userProfile = profile
            self?.userId = profile?.id
            completion(true)
        }
    }
    func fetchUserDetails(completion: @escaping (Bool) -> Void) {
            profileService.fetchUserDetails { [weak self] details, error in
                if let error = error {
                    print("Error fetching user details: \(error)")
                    completion(false)
                    return
                }
                self?.userDetails = details
                completion(true)
            }
        }
    func followUser(userToFollowId: Int, completion: @escaping (Bool) -> Void) {
            profileService.followUser(userToFollowId: userToFollowId) { error in
                if let error = error {
                    print("Error following user: \(error)")
                    completion(false)
                    return
                }
                completion(true)
            }
        }
    func unfollowUser(userToUnfollowId: Int, completion: @escaping (Bool) -> Void) {
           profileService.unfollowUser(userToUnfollowId: userToUnfollowId) { error in
               if let error = error {
                   print("Error unfollowing user: \(error)")
                   completion(false)
                   return
               }
               completion(true)
           }
       }

    func fetchFollowersCount(completion: @escaping (Int?) -> Void) {
           profileService.fetchFollowersCount { count, error in
               if let error = error {
                   print("Error fetching followers count: \(error)")
                   completion(nil)
                   return
               }
               completion(count)
           }
       }
    func fetchFollowingCount(completion: @escaping (Int?) -> Void) {
           profileService.fetchFollowingCount { count, error in
               if let error = error {
                   print("Error fetching following count: \(error)")
                   completion(nil)
                   return
               }
               completion(count)
           }
       }
   }
