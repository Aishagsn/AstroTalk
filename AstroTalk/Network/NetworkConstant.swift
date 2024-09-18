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
        "Content-Type": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJBVVRIX0tFWSI6IkFETUlOLFVTRVIiLCJzdWIiOiJlbHRhakFkbWluIiwiaWF0IjoxNzI2NjY3NTcxLCJleHAiOjE3MjY3NTM5NzF9.XPi3GCsH5gW0Xnw-UDbtJCvXlr8kKX2wYq7qSbej_cA"
    ]
    
    static func getUrl(with endpoint: String) -> String {
        return baseURL + endpoint
    }
    static func getImageUrl(with endpoint: String) -> String {
        return baseURL + "/files/" + endpoint
    }
    
}
