//
//  Struct.swift
//  AstroTalk
//
//  Created by Aisha on 02.08.24.
//

import Foundation

struct Story: Codable {
    let profileImageName: String
    let zodiacSignImageName: String
}

struct Post: Codable  {
    let content: String
    let timeAgo: String
    let imageName: String
}

struct MotivationMessage: Codable  {
    let imageName: String
}

