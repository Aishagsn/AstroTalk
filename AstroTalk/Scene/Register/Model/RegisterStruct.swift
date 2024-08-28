//
//  RegisterStruct.swift
//  AstroTalk
//
//  Created by Aisha on 31.07.24.
//

import Foundation
struct User: Codable {
    let username: String
    let password: String
    let name: String
    let surname: String
    let email: String
    let rePassword: String
}
