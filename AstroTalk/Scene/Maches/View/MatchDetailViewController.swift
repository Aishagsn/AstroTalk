//
//  MatchDetailViewController.swift
//  AstroTalk
//
//  Created by Aisha on 30.08.24.
//

import UIKit

class MatchDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var zodiacLabel: UILabel!
    @IBOutlet weak var risingSignLabel: UILabel!
    @IBOutlet weak var interestLabel1: UILabel!
    @IBOutlet weak var interestLabel2: UILabel!
    @IBOutlet weak var interestLabel3: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    // ViewModel instance
    var viewModel: MatchDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        // Profil resmi için yuvarlak görünüm
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
        
        // Takip butonu tasarımı
        followButton.layer.cornerRadius = 10
        followButton.backgroundColor = UIColor.systemOrange
        followButton.setTitleColor(.white, for: .normal)
    }
    
    private func bindViewModel() {
        // ViewModel'den gelen verilerle UI güncellemesi
        guard let matchDetail = viewModel?.matchDetail else { return }
        
        nameLabel.text = matchDetail.name
        ageLabel.text = "\(matchDetail.age)"
        zodiacLabel.text = matchDetail.zodiacSign
        risingSignLabel.text = matchDetail.risingSign
        
        // İlgi alanlarını UI'ya ekleme
        if matchDetail.interests.count > 0 {
            interestLabel1.text = matchDetail.interests[0]
        }
        if matchDetail.interests.count > 1 {
            interestLabel2.text = matchDetail.interests[1]
        }
        if matchDetail.interests.count > 2 {
            interestLabel3.text = matchDetail.interests[2]
        }
        
        // Profil resmini yükleme (örneğin, URL'den)
        if let imageUrl = URL(string: matchDetail.imageUrl) {
            loadImage(from: imageUrl)
        }
    }
    
    private func loadImage(from url: URL) {
        // URL'den resim yükleme kodu
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.profileImageView.image = image
                }
            }
        }
    }
    
    @IBAction func followButtonTapped(_ sender: UIButton) {
        // Takip butonu işlevselliği
        print("Takip et butonuna basıldı.")
        // ViewModel üzerinden takip işlevselliği
        viewModel?.followUser()
    }
}

