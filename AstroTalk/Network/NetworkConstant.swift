//
//  NetworkConstant.swift
//  AstroTalk
//
//  Created by Aisha on 05.09.24.
//

import Foundation
import Alamofire

class NetworkConstant {
//    static let baseURL = "http://35.223.201.116:8088/"
    static let baseURL = "http://34.28.199.212:8088/"
    static let header: HTTPHeaders = [
        "Content-Type": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJBVVRIX0tFWSI6IlVTRVIsQURNSU4iLCJzdWIiOiJlbHRhakFkbWluIiwiaWF0IjoxNzI4MzI4ODY1LCJleHAiOjE3Mjg0MTUyNjV9.tH7QEEdvowdssZdLgaUTbamFP0grM8CGCBDqdx0ogVg"
    ]
    
    static func getUrl(with endpoint: String) -> String {
        return baseURL + endpoint
    }
    static func getImageUrl(with endpoint: String) -> String {
        return baseURL + "/files/" + endpoint
    }
    
}
