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
        loadImage()
    }
    
    private func bindViewModel() {
        let planet = viewModel.planets[planetIndex]
               descriptionLabel.text = planet.about
    }
    
    private func loadImage() {
        viewModel.loadImage(for: planetIndex) { [weak self] data in
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        self?.imageView.image = UIImage(data: data)
                    }
                }
            }
        }

