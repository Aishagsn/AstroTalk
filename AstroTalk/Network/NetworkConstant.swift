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
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJBVVRIX0tFWSI6IkFETUlOLFVTRVIiLCJzdWIiOiJlbHRhakFkbWluIiwiaWF0IjoxNzI2NDM4OTUwLCJleHAiOjE3MjY1MjUzNTB9.-MmXFPRLo4umP4BBa72h3Bpiv801mLNdrw-EC2v2A70"
    ]
    
    static func getUrl(with endpoint: String) -> String {
        return baseURL + endpoint
    }
    static func getImageUrl(with endpoint: String) -> String {
        return baseURL + "/files/" + endpoint
    }
    
}
