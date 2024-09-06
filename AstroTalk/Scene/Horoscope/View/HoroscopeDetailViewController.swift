//
//  HoroscopeDetailViewController.swift
//  AstroTalk
//
//  Created by Aisha on 28.08.24.
//

import UIKit
import Kingfisher

class HoroscopeDetailViewController: UIViewController {
  
    
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var monthlyLabel: UIButton!
    @IBOutlet weak var weeklyLabel: UIButton!
    @IBOutlet weak var dailyLabel: UIButton!
    @IBOutlet weak var horoscopeImage: UIImageView!
    var viewModel: HoroscopeDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI() {
        self.title = viewModel.features
           
           informationLabel.text = "\(viewModel.planet) - \(viewModel.features)"
           dailyLabel.setTitle(viewModel.type, for: .normal)
           weeklyLabel.setTitle(viewModel.type, for: .normal)
           monthlyLabel.setTitle(viewModel.type, for: .normal)
           
           if let planetImageURL = URL(string: viewModel.planet) {
               horoscopeImage.kf.setImage(with: planetImageURL)
           } else {
               horoscopeImage.image = UIImage(named: "defaultPlanetImage")
           }
       }
   
    
    
    }
    
    
