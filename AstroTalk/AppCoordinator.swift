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
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginController") as? LoginController else {
            fatalError("LoginController not found in storyboard.")
        }
        let loginViewModel = LoginViewModel()
        loginVC.viewModel = loginViewModel
        // Set the root view controller of the navigation controller to the login view controller
        navigationController.setViewControllers([loginVC], animated: false)
    }
    
    func navigateToRegister() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let registerVC = storyboard.instantiateViewController(withIdentifier: "RegisterController") as? RegisterController else {
            fatalError("RegisterController not found in storyboard.")
        }
        let RegisterViewModel = RegisterViewModel()
        registerVC.viewModel = RegisterViewModel
        navigationController.setViewControllers([registerVC], animated: false)
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
            let planetViewModel = PlanetViewModel(coordinator: self, planetService: planetService)
        
        let planetVC = PlanetViewController(viewModel: planetViewModel)
//            planetVC.viewModel = planetViewModel
            navigationController.pushViewController(planetVC, animated: true)
        }
        
        func showPlanetDetail(for planet: Planet) {
            let detailViewModel = PlanetDetailViewModel(planet: planet)
            let detailVC = PlanetDetailViewController()
            detailVC.viewModel = detailViewModel
            navigationController.pushViewController(detailVC, animated: true)
        }
    }

