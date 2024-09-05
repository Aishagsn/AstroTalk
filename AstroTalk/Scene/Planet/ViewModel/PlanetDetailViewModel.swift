//
//  PlanetDetailViewModel.swift
//  AstroTalk
//
//  Created by Aisha on 24.08.24.
//

import Foundation

class PlanetDetailViewModel {
    var planet: Observable<Planet>
    
    init(planet: Planet) {
        self.planet = Observable(planet)
    }
    func loadImage(completion: @escaping (Data?) -> Void) {
            let imageUrl = planet.value.imageUrl
            
            NetworkManager.request(model: Data.self, endpoint: imageUrl, method: .get) { data, error in
                if let error = error {
                    print("Failed to load image: \(error)")
                    completion(nil)
                    return
                }
                completion(data)
            }
        }
    }
