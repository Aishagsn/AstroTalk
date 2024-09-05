//
//  NetworkConstant.swift
//  AstroTalk
//
//  Created by Aisha on 05.09.24.
//

import Foundation
import Alamofire

class NetworkConstant {
    static let baseURL = "http://35.223.201.116:8088/"
    static let header: HTTPHeaders = [
        "Content-Type": "application/json"
        
    ]
    
    static func getUrl(with endpoint: String) -> String {
        return baseURL + endpoint
    }
}
