//
//  PlanetViewModel.swift
//  AstroTalk
//
//  Created by Aisha on 24.08.24.
//

import Foundation

class PlanetViewModel {
    var onPlanetsUpdated: (() -> Void)?
    var planets: [Planet] = []
    private let planetService = PlanetService()
    var coordinator: AppCoordinator?

    func fetchPlanets() {
        planetService.fetchPlanets { [weak self] result in
            switch result {
            case .success(let planets):
                    self?.planets = planets
                    self?.onPlanetsUpdated?()
            case .failure(let error):
                print("Failed to fetch planets: \(error.localizedDescription)")
            }
        }
    }

    func didSelectPlanet(at indexPath: IndexPath) {
        let selectedPlanet = planets[indexPath.row]
        coordinator?.showPlanetDetail(for: selectedPlanet)
    }

    func planet(at index: Int) -> Planet {
        return planets[index]
    }
}
