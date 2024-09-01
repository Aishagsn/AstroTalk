//
//  MatchDetail.swift
//  AstroTalk
//
//  Created by Aisha on 30.08.24.
//

import Foundation
struct MatchDetail: Codable {
    let name: String
    let age: Int
    let zodiacSign: String
    let risingSign: String
    let interests: [String]
    let imageUrl: String
    let about: String
}
