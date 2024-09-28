//
//  ProfileViewController.swift
//  AstroTalk
//
//  Created by Aisha on 28.09.24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var horoscopeSignLabel: UILabel!
    @IBOutlet weak var risingSignLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var unfollowButton: UIButton!
    @IBOutlet weak var interest1Label: UILabel!
       @IBOutlet weak var interest2Label: UILabel!
       @IBOutlet weak var interest3Label: UILabel!
       
        
    var viewModel: ProfileViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        populateFields()
    }
    
    private func populateFields() {
        guard let profile = viewModel?.userProfile else { return }
        
        nameLabel.text = profile.firstName
        lastNameLabel.text = profile.lastName
        usernameLabel.text = profile.username
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        birthdayLabel.text = dateFormatter.string(from: profile.birthday ?? Date())
        
        // Calculate and display the zodiac and rising signs
        horoscopeSignLabel.text = calculateZodiacSign(from: profile.birthday ?? Date())
        risingSignLabel.text = calculateRisingSign(from: profile.birthday ?? Date(), time: profile.birthdayTime ?? Date())
        
        interest1Label.text = profile.interests?[0] ?? "No interest available."
               interest2Label.text = profile.interests?.count > 1 ? profile.interests?[1] : "No interest available."
               interest3Lab
        followersCountLabel.text = "Followers: \(profile.followersCount ?? 0)"
        followingCountLabel.text = "Following: \(profile.followingCount ?? 0)"
        
        if let imageData = profile.profileImage {
            profileImageView.image = UIImage(data: imageData)
        }
    }

    private func calculateZodiacSign(from birthday: Date) -> String {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: birthday)
        let day = calendar.component(.day, from: birthday)
        
        switch (month, day) {
        case (1, 20...31), (2, 1...18): return "Aquarius"
        case (2, 19...29), (3, 1...20): return "Pisces"
        case (3, 21...31), (4, 1...19): return "Aries"
        case (4, 20...30), (5, 1...20): return "Taurus"
        case (5, 21...31), (6, 1...20): return "Gemini"
        case (6, 21...30), (7, 1...22): return "Cancer"
        case (7, 23...31), (8, 1...22): return "Leo"
        case (8, 23...31), (9, 1...22): return "Virgo"
        case (9, 23...30), (10, 1...22): return "Libra"
        case (10, 23...31), (11, 1...21): return "Scorpio"
        case (11, 22...30), (12, 1...21): return "Sagittarius"
        case (12, 22...31), (1, 1...19): return "Capricorn"
        default: return "Unknown"
        }
    }

    private func calculateRisingSign(from birthday: Date, time: Date) -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: time)
        
        switch hour {
        case 0...2: return "Pisces" // Midnight - 2 AM
        case 3...5: return "Aries" // 3 AM - 5 AM
        case 6...8: return "Taurus" // 6 AM - 8 AM
        case 9...11: return "Gemini" // 9 AM - 11 AM
        case 12...14: return "Cancer" // 12 PM - 2 PM
        case 15...17: return "Leo" // 3 PM - 5 PM
        case 18...20: return "Virgo" // 6 PM - 8 PM
        case 21...23: return "Libra" // 9 PM - 11 PM
        default: return "Unknown"
        }
    }

    @IBAction func followButtonTapped(_ sender: UIButton) {
        let userToFollowId = viewModel?.userProfile?.id ?? 0
        viewModel?.followUser(userToFollowId: userToFollowId) { success in
            DispatchQueue.main.async {
                if success {
                    self.showAlert(message: "Successfully followed \(self.usernameLabel.text ?? "").")
                } else {
                    self.showAlert(message: "Failed to follow the user.")
                }
            }
        }
    }

    @IBAction func unfollowButtonTapped(_ sender: UIButton) {
        let userToUnfollowId = viewModel?.userProfile?.id ?? 0 
        viewModel?.unfollowUser(userToUnfollowId: userToUnfollowId) { success in
            DispatchQueue.main.async {
                if success {
                    self.showAlert(message: "Successfully unfollowed \(self.usernameLabel.text ?? "").")
                } else {
                    self.showAlert(message: "Failed to unfollow the user.")
                }
            }
        }
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
