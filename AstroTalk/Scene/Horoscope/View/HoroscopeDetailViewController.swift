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
    @IBOutlet weak var planetLabel: UILabel!
    @IBOutlet weak var horoscopeImage: UIImageView!
//    var viewModel: HoroscopeDetailViewModel!
//    var horoscope: Horoscope?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        fetchHoroscopeDetail()
//    }
//    //    private func setupUI() {
//    //        self.title = viewModel.features
//    //
//    //        informationLabel.text = "\(viewModel.planet) - \(viewModel.features)"
//    //        dailyLabel.setTitle(viewModel.type, for: .normal)
//    //        weeklyLabel.setTitle(viewModel.type, for: .normal)
//    //        monthlyLabel.setTitle(viewModel.type, for: .normal)
//    //
//    //        if let planetImageURL = URL(string: viewModel.planet) {
//    //            horoscopeImage.kf.setImage(with: planetImageURL)
//    //        } else {
//    //            horoscopeImage.image = UIImage(named: "defaultPlanetImage")
//    //        }
//    //    }
//    
//    
//    private func setupUI() {
//        guard let horoscope = horoscope else {
//            print("No horoscope data available")
//            return
//        }
//        if let imageUrlString = horoscope.image, let imageUrl = URL(string: "http://35.223.201.116:8088/files/" + imageUrlString) {
//            horoscopeImage.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholderImage"))
//        } else {
//            horoscopeImage.image = UIImage(named: "placeholderImage")
//        }
//        informationLabel.text = "\(viewModel.planet) - \(viewModel.features)"
//        dailyLabel.setTitle(viewModel.type, for: .normal)
//        weeklyLabel.setTitle(viewModel.type, for: .normal)
//        monthlyLabel.setTitle(viewModel.type, for: .normal)
//    }
//    
//    private func fetchHoroscopeDetail() {
//        viewModel.fetchHoroscopeDetail { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success:
//                    self?.setupUI()
//                case .failure(let error):
//                    print("Failed to fetch horoscope detail: \(error)")
//                }
//            }
//        }
//    }
//}
    
       var viewModel: HoroscopeDetailViewModel!
       var horoscope: Horoscope? // Add this to hold the Horoscope object
       
       override func viewDidLoad() {
           super.viewDidLoad()
           fetchHoroscopeDetail()
           
           // Add button actions
           dailyLabel.addTarget(self, action: #selector(dailyButtonTapped), for: .touchUpInside)
           weeklyLabel.addTarget(self, action: #selector(weeklyButtonTapped), for: .touchUpInside)
           monthlyLabel.addTarget(self, action: #selector(monthlyButtonTapped), for: .touchUpInside)
       }

       // Button Actions
       @objc private func dailyButtonTapped() {
           updateInformationLabel(for: "Daily")
       }
       
       @objc private func weeklyButtonTapped() {
           updateInformationLabel(for: "Weekly")
       }
       
       @objc private func monthlyButtonTapped() {
           updateInformationLabel(for: "Monthly")
       }
  
    private func updateInformationLabel(for period: String) {
        guard let viewModel = viewModel else {
            informationLabel.text = "No data available"
            return
        }
        
        let details = viewModel.horoscopeDetail 
        
        switch period {
        case "Daily":
            informationLabel.text = "Daily Horoscope: \(details?.features ?? "No features available")"
        case "Weekly":
            informationLabel.text = "Weekly Horoscope: \(details?.features ?? "No features available")"
        case "Monthly":
            informationLabel.text = "Monthly Horoscope: \(details?.features ?? "No features available")"
        default:
            informationLabel.text = "Unknown Period"
        }
        
        informationLabel.isHidden = false
    }

       
       private func fetchHoroscopeDetail() {
           viewModel.fetchHoroscopeDetail { [weak self] result in
               DispatchQueue.main.async {
                   switch result {
                   case .success:
                       self?.setupUI()
                   case .failure(let error):
                       print("Failed to fetch horoscope detail: \(error)")
                   }
               }
           }
       }
       
    private func setupUI() {
        if let horoscope = horoscope, let imageUrl = URL(string: horoscope.image ?? "") {
                horoscopeImage.kf.setImage(with: imageUrl)
            }
            informationLabel.text = "Select a period to view details"
            informationLabel.isHidden = false
        }
   }
