//
//  Horoscope.swift
//  AstroTalk
//
//  Created by Aisha on 28.08.24.
//

import Foundation
struct Horoscope: Codable {
    let name: String
    let dateRange: String
    let planet: String
    let daily: String
    let weekly: String
    let monthly: String
}
