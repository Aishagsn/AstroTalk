//
//  PlanetDetailViewModel.swift
//  AstroTalk
//
//  Created by Aisha on 24.08.24.
//

import Foundation
import Kingfisher
import UIKit
import Alamofire

class PlanetDetailViewModel {
    private let id: Int
    var planets: [Planet] = []
    
    init(id: Int) {
        self.id = id
    }
    
    func loadImage(for index: Int, completion: @escaping (Data?) -> Void) {
        guard index < planets.count else {
            print("Index out of bounds")
            completion(nil)
            return
        }
        
        let imageUrl = planets[index].image ?? ""
        AF.request(imageUrl).response { response in
            if let data = response.data {
                completion(data)
            } else {
                print("Failed to load image with error: \(response.error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }
    }
}
