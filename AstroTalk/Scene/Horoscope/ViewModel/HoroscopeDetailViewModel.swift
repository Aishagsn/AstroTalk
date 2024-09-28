//
//  HoroscopeDetailViewModel.swift
//  AstroTalk
//
//  Created by Aisha on 28.08.24.
//

import Foundation

class HoroscopeDetailViewModel {
    private let id: Int
    var horoscopeDetail: HoroscopeDetail?
    var horoscopes: [Horoscope] = []

    init(id: Int) {
        self.id = id
    }
    
    // Function to fetch horoscope details based on the id
    func fetchHoroscopeDetail(completion: @escaping (Result<HoroscopeDetail, Error>) -> Void) {
        let endpoint = "horoscope-details/\(id)" 

        NetworkManager.request(model: HoroscopeDetail.self, endpoint: endpoint, method: .get) { result, error in
            if let error = error {
                completion(.failure(NetworkError.customError(error)))
            } else if let result = result {
                self.horoscopeDetail = result
                completion(.success(result))
            } else {
                completion(.failure(NetworkError.noData))
            }
        }
    }
 
    var features: String {
        return horoscopeDetail?.features ?? "Features not available"
    }

    var planet: String {
        return horoscopeDetail?.planet ?? "Planet not available"
    }

    var type: String {
        return horoscopeDetail?.type ?? "Type not available"
    }
}
