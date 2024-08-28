//
//  PlanetService.swift
//  AstroTalk
//
//  Created by Aisha on 24.08.24.
//

import Foundation

class PlanetService {
    let baseURL = "http://localhost:5000/api/Planets/1"
    
    func fetchPlanets(completion: @escaping (Result<[Planet], Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let planets = try JSONDecoder().decode([Planet].self, from: data)
                completion(.success(planets))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
}
