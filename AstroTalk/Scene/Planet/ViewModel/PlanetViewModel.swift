//
//  PlanetViewModel.swift
//  AstroTalk
//
//  Created by Aisha on 24.08.24.
//

import Foundation

class PlanetViewModel {
    var coordinator: AppCoordinator? 
      private let planetService = PlanetService()
      var planets: Observable<[Planet]> = Observable([])
      
    
    
    func fetchPlanets() {
        planetService.fetchPlanets { [weak self] result in
            switch result {
            case .success(let planets):
                DispatchQueue.main.async {
                    self?.planets.value = planets
                }
            case .failure(let error):
                print("Failed to fetch planets: \(error.localizedDescription)")
            }
            
        }
    }
    
    func didSelectPlanet(at indexPath: IndexPath) {
        let selectedPlanet = planets.value[indexPath.row]
        coordinator?.showPlanetDetail(for: selectedPlanet)
    }
}
