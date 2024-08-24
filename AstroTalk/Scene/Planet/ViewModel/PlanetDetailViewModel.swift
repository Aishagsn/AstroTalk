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
        guard let url = URL(string: planet.value.imageUrl) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            completion(data)
        }
        task.resume()
    }
}
