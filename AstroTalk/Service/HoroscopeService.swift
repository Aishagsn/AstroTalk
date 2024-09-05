//
//  HoroscopeService.swift
//  AstroTalk
//
//  Created by Aisha on 28.08.24.
//

import Foundation
import Alamofire

class HoroscopeService {
    func fetchHoroscope(for sign: String, period: String, completion: @escaping (Horoscope?) -> Void) {
        let endpoint = "horoscope/\(period)"
        let parameters: Parameters = ["sign": sign]
        
        NetworkManager.request(model: Horoscope.self, endpoint: endpoint, method: .get, parameters: parameters) { (response, error) in
            if let error = error {
                print("Error fetching horoscope: \(error)")
                completion(nil)
            } else if let horoscope = response {
                completion(horoscope)
            }
        }
    }
}
