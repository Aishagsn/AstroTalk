//
//  UserProfile .swift
//  AstroTalk
//
//  Created by Aisha on 28.09.24.
//

import Foundation
struct UserProfile: Codable {
    var id: Int?
    var firstName: String?
    var lastName: String?
    var email: String?
    var username: String?
    var followersCount: Int?
    var followingCount: Int?
}
