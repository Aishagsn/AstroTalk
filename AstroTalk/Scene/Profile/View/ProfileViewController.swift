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
        fetchUserProfile()
        fetchUserFollowersAndFollowing()
    }
    private func fetchUserProfile() {
        viewModel?.fetchUserProfile { [weak self] success in
            if success {
                if let userProfile = self?.viewModel?.userProfile, let userDetails = self?.viewModel?.userDetails {
                    self?.updateProfileFields(profile: userProfile, userDetails: userDetails)
                }
            } else {
                print("Error fetching user profile")
            }
        }
    }
        
    func fetchUserFollowersAndFollowing() {
        viewModel?.fetchFollowersCount { [weak self] followersCount in
            DispatchQueue.main.async {
                if let followersCount = followersCount {
                    self?.followersCountLabel.text = "Followers: \(followersCount)"
                } else {
                    self?.followersCountLabel.text = "Followers: N/A"
                }
            }
        }
        
        viewModel?.fetchFollowingCount { [weak self] followingCount in
            DispatchQueue.main.async {
                if let followingCount = followingCount {
                    self?.followingCountLabel.text = "Following: \(followingCount)"
                } else {
                    self?.followingCountLabel.text = "Following: N/A"
                }
            }
        }
    }

    private func updateProfileFields(profile: User?, userDetails: UserDetails?) {
            guard let profile = profile, let userDetails = userDetails else { return }
            
                guard let profile = viewModel?.userProfile, let userDetails = viewModel?.userDetails  else { return }
                
                nameLabel.text = profile.firstName
                lastNameLabel.text = profile.lastName
                usernameLabel.text = profile.username
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                if let dateOfBirthString = userDetails.dateOfBirth {
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    if let dateOfBirth = dateFormatter.date(from: dateOfBirthString) {
                        birthdayLabel.text = dateFormatter.string(from: dateOfBirth)
                        horoscopeSignLabel.text = calculateZodiacSign(from: dateOfBirth)
                    } else {
                        birthdayLabel.text = "Invalid date format."
                    }
                } else {
                    birthdayLabel.text = "No birthday available."
                }
        if let timeOfBirthString = userDetails.timeOfBirth {
          
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            if let timeOfBirth = timeFormatter.date(from: timeOfBirthString) {
                if let dateOfBirthString = userDetails.dateOfBirth {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    
                    if let dateOfBirth = dateFormatter.date(from: dateOfBirthString) {
                        let risingSign = calculateRisingSign(from: dateOfBirth, time: timeOfBirth)
                        risingSignLabel.text = risingSign
                    } else {
                        risingSignLabel.text = "Invalid date of birth format."
                    }
                }
            } else {
                risingSignLabel.text = "Invalid time of birth format."
            }
        } else {
            risingSignLabel.text = "No time of birth available."
        }

                
                if let interests = userDetails.interests {
                    interest1Label.text = interests.count > 0 ? interests[0] : "No interest available."
                    interest2Label.text = interests.count > 1 ? interests[1] : "No interest available."
                    interest3Label.text = interests.count > 2 ? interests[2] : "No interest available."
                } else {
                    interest1Label.text = "No interest available."
                    interest2Label.text = "No interest available."
                    interest3Label.text = "No interest available."
                }
                
                if let imageData = userDetails.image, let data = Data(base64Encoded: imageData) {
                    profileImageView.image = UIImage(data: data)
                }
            }
            
            func calculateZodiacSign(from birthday: Date) -> String {
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
            
            func calculateRisingSign(from birthday: Date, time: Date) -> String {
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: time)
                
                switch hour {
                case 0...2: return "Pisces"
                case 3...5: return "Aries"
                case 6...8: return "Taurus"
                case 9...11: return "Gemini"
                case 12...14: return "Cancer"
                case 15...17: return "Leo"
                case 18...20: return "Virgo"
                case 21...23: return "Libra"
                default: return "Unknown"
                }
            }
            
            @IBAction func followButtonTapped(_ sender: UIButton) {
                let userToFollowId = viewModel?.userProfile?.id ?? 0
                viewModel?.followUser(userToFollowId: userToFollowId) { success in
                    DispatchQueue.main.async {
                        if success {
                            self.showAlert(message: "Successfully followed \(self.usernameLabel.text ?? "").")
                            self.fetchUserFollowersAndFollowing()
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
                            self.fetchUserFollowersAndFollowing()
                        } else {
                            self.showAlert(message: "Failed to unfollow the user.")
                        }
                    }
                }
            }
            
            func showAlert(message: String) {
                let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
            }
        }
    
