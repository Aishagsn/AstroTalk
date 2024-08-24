//
//  PlanetViewModel.swift
//  AstroTalk
//
//  Created by Aisha on 24.08.24.
//

import Foundation

class PlanetViewModel {
    private let coordinator: AppCoordinator
    private let planetService: PlanetService
    var planets: Observable<[Planet]> = Observable([])
    
    init(coordinator: AppCoordinator, planetService: PlanetService = PlanetService()) {
        self.coordinator = coordinator
        self.planetService = planetService
    }
    
    func fetchPlanets() {
        planetService.fetchPlanets { [weak self] result in
            switch result {
            case .success(let planets):
                DispatchQueue.main.async {
                    self?.planets.value = planets
                }
            case .failure(let error):
                print("Failed to fetch planets: \(error)")
            }
        }
    }
    
    func didSelectPlanet(at indexPath: IndexPath) {
        let selectedPlanet = planets.value[indexPath.row]
        coordinator.showPlanetDetail(for: selectedPlanet)
    }
}
