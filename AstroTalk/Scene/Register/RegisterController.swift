//
//  RegisterController.swift
//  AstroTalk
//
//  Created by Aisha on 27.07.24.
//

import UIKit

class RegisterController: UIViewController {
    
    @IBOutlet private weak var reTypePasswordTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var surnameTextField: UITextField!
    @IBOutlet private weak var nameTextField: UITextField!
    
    var viewModel = RegisterViewModel()
    var coordinator : AppCoordinator
    init(viewModel: RegisterViewModel, coordinator: AppCoordinator) {
            self.viewModel = viewModel
            self.coordinator = coordinator
            super.init(nibName: nil, bundle: nil)
        }

        // Required initializer for storyboard
        required init?(coder: NSCoder) {
            self.viewModel = RegisterViewModel()  // Default initialization
            // Initialize with a default or dummy UINavigationController
            let defaultNavigationController = UINavigationController()
            self.coordinator = AppCoordinator(navigationController: defaultNavigationController)
            super.init(coder: coder)
        }
    override func viewDidLoad() {
            super.viewDidLoad()
            bindViewModel()
            coordinator.navigateToRegister()
        }
        @IBAction func registerTappedButton(_ sender: Any) {
            guard let name = nameTextField.text, !name.isEmpty,
                  let surname = surnameTextField.text, !surname.isEmpty,
                  let username = usernameTextField.text, !username.isEmpty,
                  let email = emailTextField.text, !email.isEmpty,
                  let password = passwordTextField.text, !password.isEmpty,
                  let reTypePassword = reTypePasswordTextField.text, !reTypePassword.isEmpty else {
                showAlert(title: "Error", message: "All fields are required.")
                return
            }
            
            guard password == reTypePassword else {
                showAlert(title: "Error", message: "Passwords do not match.")
                return
            }
            
            let user = User(name: name, surname: surname, username: username, email: email, password: password)
            viewModel.registerUser(user: user)
        }
        
        @IBAction func loginTappedButton(_ sender: Any) {
            coordinator.start()
        }
        
       private func bindViewModel() {
            viewModel.onError = { [weak self] errorMessage in
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: errorMessage)
                }
            }
            
            viewModel.onSuccess = { [weak self] in
                DispatchQueue.main.async {
                    self?.showAlert(title: "Success", message: "Registration successful!") {
                        self?.coordinator.start()
                    }
                }
            }
        }
        
         private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
               let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
               let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                   completion?()
               }
               alert.addAction(okAction)
               present(alert, animated: true, completion: nil)
           }
       }
    
