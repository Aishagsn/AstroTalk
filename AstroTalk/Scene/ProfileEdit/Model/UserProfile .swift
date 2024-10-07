//
//  UserProfile .swift
//  AstroTalk
//
//  Created by Aisha on 28.09.24.
//

import Foundation
struct User: Codable {
    var id: Int?
    var firstName: String?
    var lastName: String?
    var email: String?
    var username: String?
}
struct UserDetails: Codable {
    var id: Int?
    var gender: String?
    var dateOfBirth: String?
    var interests: [String]?
    var timeOfBirth: String?
    var image: String?
}
