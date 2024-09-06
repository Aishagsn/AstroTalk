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
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJBVVRIX0tFWSI6IlVTRVIsQURNSU4iLCJzdWIiOiJlbHRhakFkbWluIiwiaWF0IjoxNzI1NjM1MzUyLCJleHAiOjE3MjU3MjE3NTJ9.ta0RNiv9WlVDJJ87y6qBI0edte7L_zclt4e16dD3iv4"
    ]
    
    static func getUrl(with endpoint: String) -> String {
        return baseURL + endpoint
    }
    static func getImageUrl(with endpoint: String) -> String {
        return baseURL + "/files/" + endpoint
    }
    
}
