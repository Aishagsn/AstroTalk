//
//  PlanetDetailViewController.swift
//  AstroTalk
//
//  Created by Aisha on 24.08.24.
//

import UIKit

class PlanetDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var viewModel: PlanetDetailViewModel!
    var planetIndex: Int = 0 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        loadImage(for: planetIndex)
    }
    
    private func bindViewModel() {
        guard !viewModel.planets.isEmpty, planetIndex < viewModel.planets.count else {
                   showError(message: "No data available or index out of bounds")
                   return
               }
               
               let planet = viewModel.planets[planetIndex]
               descriptionLabel.text = planet.about
               loadImage(for: planetIndex)
           }
    
    private func loadImage(for index: Int) {
        viewModel.loadImage(for: index) { [weak self] data in
            DispatchQueue.main.async {
                if let data = data {
                    self?.imageView.image = UIImage(data: data)
                } else {
                    self?.imageView.image = UIImage(named: "placeholder") 
                }
            }
        }
    }

    
       private func showError(message: String) {
           let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default))
           present(alert, animated: true)
       }
        }

