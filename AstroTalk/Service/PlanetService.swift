//
//  PlanetService.swift
//  AstroTalk
//
//  Created by Aisha on 24.08.24.
//

import Foundation

class PlanetService {
    func fetchPlanets(completion: @escaping (Result<[Planet], Error>) -> Void) {
        NetworkManager.request(model: [Planet].self,
                                     endpoint: "api/Planets/1",
                                     method: .get) { planets, error in
            if let error = error {
                completion(.failure(NetworkError.customError(error)))
            } else if let planets = planets {
                completion(.success(planets))
            } else {
                completion(.failure(NetworkError.noData))
            }
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case customError(String)
}
