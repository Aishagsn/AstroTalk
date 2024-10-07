//
//  ProfileEditController.swift
//  AstroTalk
//
//  Created by Aisha on 28.09.24.
//
//
//  ProfileEditController.swift
//  AstroTalk
//
//  Created by Aisha on 28.09.24.
//

import UIKit
import Kingfisher


class ProfileEditController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var viewModel = ProfileViewModel()
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var birthdayTextField: UITextField! 
    @IBOutlet weak var timeTextField: UITextField!

    private let datePicker = UIDatePicker()
    private let timePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserProfile()
        loadFollowersAndFollowingCount()
        setupBirthdayPicker()
        setupTimePicker()
        
       
        birthdayTextField.isUserInteractionEnabled = false
        timeTextField.isUserInteractionEnabled = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectProfileImage))
                profileImageView.isUserInteractionEnabled = true
                profileImageView.addGestureRecognizer(tapGesture)
            
    }

    func loadUserProfile() {
        viewModel.fetchUserProfile { success in
            DispatchQueue.main.async {
                if success, let profile = self.viewModel.userProfile {
                    self.firstNameTextField.text = profile.firstName
                    self.lastNameTextField.text = profile.lastName
                    self.usernameTextField.text = profile.username
                    self.emailTextField.text = profile.email
                    if let userDetails = self.viewModel.userDetails {
                        self.birthdayTextField.text = userDetails.dateOfBirth
                        self.timeTextField.text = userDetails.timeOfBirth
                        if let imageURLString = userDetails.image, let url = URL(string: imageURLString) {
                            self.profileImageView.kf.setImage(with: url)
                        }
                    }
                } else {
                    self.showAlert(message: "Failed to load profile.")
                }
            }
        }
    }

    func loadFollowersAndFollowingCount() {
        viewModel.fetchFollowersCount { count in
            DispatchQueue.main.async {
                self.followersCountLabel.text = "Followers: \(count ?? 0)"
            }
        }

        viewModel.fetchFollowingCount { count in
            DispatchQueue.main.async {
                self.followingCountLabel.text = "Following: \(count ?? 0)"
            }
        }
    }

    func setupBirthdayPicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels // Use wheels style
        birthdayTextField.inputView = datePicker
        let toolbar = createToolbar(selector: #selector(donePressedBirthday))
        birthdayTextField.inputAccessoryView = toolbar
    }

    func setupTimePicker() {
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels // Use wheels style
        timePicker.minuteInterval = 1 // Set minute interval for time picker
        timeTextField.inputView = timePicker
        let toolbar = createToolbar(selector: #selector(donePressedTime))
        timeTextField.inputAccessoryView = toolbar
    }

    @objc func donePressedBirthday() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium // Change to your preferred date format
        birthdayTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true) // Dismiss the keyboard and date picker
    }

    @objc func donePressedTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/mm/yyyy" 
        timeTextField.text = formatter.string(from: timePicker.date)
        self.view.endEditing(true)
    }

    private func createToolbar(selector: Selector) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: selector)
        toolbar.items = [flexSpace, doneButton]
        return toolbar
    }
    @objc func selectProfileImage() {
        let actionSheet = UIAlertController(title: "Select Photo", message: "Choose a source", preferredStyle: .actionSheet)
        
        // Option to take a photo using the camera
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default) { _ in
                self.openCamera()
            })
        }
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default) { _ in
            self.openPhotoLibrary()
        })
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true)
    }

    func openCamera() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true)
    }

    func openPhotoLibrary() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
    }

    func followUser(userToFollowId: Int) {
        viewModel.followUser(userToFollowId: userToFollowId) { success in
            DispatchQueue.main.async {
                if success {
                    self.showAlert(message: "Successfully followed the user.")
                    self.loadFollowersAndFollowingCount()
                } else {
                    self.showAlert(message: "Failed to follow the user.")
                }
            }
        }
    }

    func unfollowUser(userToUnfollowId: Int) {
        viewModel.unfollowUser(userToUnfollowId: userToUnfollowId) { success in
            DispatchQueue.main.async {
                if success {
                    self.showAlert(message: "Successfully unfollowed the user.")
                    self.loadFollowersAndFollowingCount()
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
