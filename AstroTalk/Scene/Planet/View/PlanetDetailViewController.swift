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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        loadImage()
    }
    
    private func bindViewModel() {
        viewModel.planet.bind { [weak self] planet in
            self?.descriptionLabel.text = planet.description
        }
    }
    
    private func loadImage() {
        viewModel.loadImage { [weak self] data in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self?.imageView.image = UIImage(data: data)
            }
        }
    }
}

