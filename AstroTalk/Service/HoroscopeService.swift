//
//  HoroscopeService.swift
//  AstroTalk
//
//  Created by Aisha on 28.08.24.
//

import Foundation
import Alamofire

class HoroscopeService {
//    func fetchHoroscope(for sign: String, period: String, completion: @escaping (Horoscope?) -> Void) {
//        let endpoint = "/api/horoscope"
//        let parameters: Parameters = ["sign": sign]
//        
//        NetworkManager.request(model: Horoscope.self, endpoint: endpoint, method: .get, parameters: parameters) { (response, error) in
//            if let error = error {
//                print("Error fetching horoscope: \(error)")
//                completion(nil)
//            } else if let horoscope = response {
//                completion(horoscope)
//            }
//        }
//    }
    func fetchHoroscope(completion: @escaping (Result<[Horoscope], Error>) -> Void) {
        NetworkManager.request(model: [Horoscope].self,
                                     endpoint: "api/horoscope",
                                     method: .get) { horoscopes, error in
            if let error = error {
                completion(.failure(NetworkErrorHoroscope.customError(error)))
            } else if let horoscopes = horoscopes {
                completion(.success(horoscopes))
            } else {
                completion(.failure(NetworkErrorHoroscope.noData))
            }
        }
    }
}
enum NetworkErrorHoroscope: Error {
    case invalidURL
    case noData
    case customError(String)
}
