//
//  MatchDetailViewController.swift
//  AstroTalk
//
//  Created by Aisha on 30.08.24.
//

import UIKit
import Kingfisher

class MatchDetailViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var zodiacLabel: UILabel!
    @IBOutlet weak var risingSignLabel: UILabel!
    @IBOutlet weak var interestLabel1: UILabel!
    @IBOutlet weak var interestLabel2: UILabel!
    @IBOutlet weak var interestLabel3: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    var viewModel: MatchDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        updateFollowButton()
    }
    
    private func setupUI() {
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
        
        followButton.layer.cornerRadius = 10
        followButton.backgroundColor = UIColor.systemOrange
        followButton.setTitleColor(.white, for: .normal)
    }
    
    @IBAction func followButtonTapped(_ sender: Any) {
        viewModel?.followUser { [weak self] success, error in
            DispatchQueue.main.async {
                if success {
                    self?.updateFollowButton()
                } else if let error = error {
                    self?.showError(error)
                }
            }
        }
    }
    private func bindViewModel() {
        guard let matchDetail = viewModel?.matchDetail else { return }
        
        nameLabel.text = matchDetail.name
        ageLabel.text = "\(matchDetail.age)"
        zodiacLabel.text = matchDetail.zodiacSign
        risingSignLabel.text = matchDetail.risingSign
        
        
        //        if matchDetail.interests.count > 0 {
        //            interestLabel1.text = matchDetail.interests[0]
        //        }
        //        if matchDetail.interests.count > 1 {
        //            interestLabel2.text = matchDetail.interests[1]
        //        }
        //        if matchDetail.interests.count > 2 {
        //            interestLabel3.text = matchDetail.interests[2]
        //        }
        let interests = matchDetail.interests
        interestLabel1.text = interests.count > 0 ? interests[0] : "N/A"
        interestLabel2.text = interests.count > 1 ? interests[1] : "N/A"
        interestLabel3.text = interests.count > 2 ? interests[2] : "N/A"
        
        if let imageUrl = URL(string: matchDetail.imageUrl) {
            profileImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholderImage"))
        }
    }
    
    private func updateFollowButton() {
        let title = viewModel?.isFollowing ?? false ? "Unfollow" : "Follow"
        followButton.setTitle(title, for: .normal)
    }
    
    
    private func showError(_ error: Error) {
        let message = error.localizedDescription
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
