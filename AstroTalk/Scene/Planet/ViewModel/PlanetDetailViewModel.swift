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
    var planet: Observable<Planet>
    
    init(planet: Planet) {
        self.planet = Observable(planet)
    }
//    func loadImage(completion: @escaping (Data?) -> Void) {
//            let imageUrl = planet.value.image
////        let imageUrl = NetworkConstant.getImageUrl(with: endpoint)
//        NetworkManager.request(model: Data.self, endpoint: imageUrl, method: .get) { data, error in
//                if let error = error {
//                    print("Failed to load image: \(error)")
//                    completion(nil)
//                    return
//                }
//                completion(data)
//            }
    //}
    func loadImage(completion: @escaping (Data?) -> Void) {
        let imageUrl = planet.value.image
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
    
