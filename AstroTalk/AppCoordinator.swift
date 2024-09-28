//
//  AppCoordinator.swift
//  AstroTalk
//
//  Created by Aisha on 21.08.24.
//

import Foundation
import UIKit

class AppCoordinator {
    var navigationController: UINavigationController
    
    // Ensure this initializer exists in AppCoordinator
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigateToRegister() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let registerVC = storyboard.instantiateViewController(withIdentifier: "RegisterController") as? RegisterController else {
            fatalError("RegisterController not found in storyboard.")
        }
        
//        let registerViewModel = RegisterViewModel(coordinator: self)
        registerVC.viewModel = .init(coordinator: self)
        navigationController.show(registerVC, sender: nil)
        //        navigationController.setViewControllers([registerVC], animated: false)
    }
    
    func navigateToHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
            let homeViewModel = HomeViewModel()
            homeVC.viewModel = homeViewModel
            
            // Present or push homeVC
            navigationController.setViewControllers([homeVC], animated: false)
        } else {
            fatalError("HomeViewController not found in storyboard.")
        }
    }
    func showPlanets() {
        let planetService = PlanetService()
        let planetViewModel = PlanetViewModel()
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let planetVC = mainStoryboard.instantiateViewController(withIdentifier: "PlanetViewController") as! PlanetViewController
        
        
        navigationController.pushViewController(planetVC, animated: true)
    }
    
    func showPlanetDetail(for planet: Planet) {
        guard let planetId = planet.id else {
               print("Planet id is not available")
               return
           }
        let detailViewModel = PlanetDetailViewModel(id: planetId)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailVC = mainStoryboard.instantiateViewController(withIdentifier: "PlanetDetailViewController") as? PlanetDetailViewController else {
            print("Failed to instantiate PlanetDetailViewController")
            return
        }
        detailVC.viewModel = detailViewModel
        navigationController.pushViewController(detailVC, animated: true)
    }

    func showHoroscopeList() {
        let horoscopeService = HoroscopeService()
        let viewModel = HoroscopeListViewModel()
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let horoscopeVC = mainStoryboard.instantiateViewController(withIdentifier: "HoroscopeListViewController") as! HoroscopeListViewController
        horoscopeVC.viewModel = viewModel
        navigationController.pushViewController(horoscopeVC, animated: true)
    }
    func showMatchList() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let matchesListVC = mainStoryboard.instantiateViewController(withIdentifier: "MatchesListViewController") as! MatchesListViewController
        let viewModel = MatchesListViewModel()
        matchesListVC.viewModel = viewModel
        matchesListVC.coordinator = self
        navigationController.pushViewController(matchesListVC, animated: true)
    }
    
    func showMatchDetail(for match: Match) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let matchDetailVC = mainStoryboard.instantiateViewController(withIdentifier: "MatchDetailViewController") as? MatchDetailViewController else {
            print("Could not instantiate MatchDetailViewController")
            return
        }
      
        let detailViewModel = MatchDetailViewModel()
     
        detailViewModel.fetchMatchDetail(for: match.name ?? "") { [weak self] matchDetail, error in
            DispatchQueue.main.async {
                if let matchDetail = matchDetail {
                    matchDetailVC.viewModel = detailViewModel
                    self?.navigationController.pushViewController(matchDetailVC, animated: true)
                } else {
                    print("Failed to fetch match details: \(error ?? "Unknown error")")
                }
            }
        }
    }


    
}
