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
    
    @IBOutlet weak var phoneTextField: UITextField!
    var viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                    bindViewModel()
      
    }
    
    @IBAction func registerTappedButton(_ sender: Any) {
        //            guard let name = nameTextField.text, !name.isEmpty,
        //                  let surname = surnameTextField.text, !surname.isEmpty,
        //                  let username = usernameTextField.text, !username.isEmpty,
        //                  let email = emailTextField.text, !email.isEmpty,
        //                  let password = passwordTextField.text, !password.isEmpty,
        //                  let reTypePassword = reTypePasswordTextField.text, !reTypePassword.isEmpty else {
        //                showAlert(title: "Error", message: "All fields are required.")
        //                return
        //            }
        //
        //            guard password == reTypePassword else {
        //                showAlert(title: "Error", message: "Passwords do not match.")
        //                return
        //            }
        //
        //            let user = User(username: username, password: password, name: name, surname: surname, email: email, rePassword: reTypePassword)
        //            viewModel.registerUser(user: user)
        //        }
        
        viewModel.registerUser(
            name: nameTextField.text,
            surname: surnameTextField.text,
            userName: usernameTextField.text,
            email: emailTextField.text,
            password: passwordTextField.text,
            phone: phoneTextField.text
           
        )
    }
    @IBAction func loginTappedButton(_ sender: Any) {
        viewModel.coordinator?.start()
    }
    
    private func bindViewModel() {
        viewModel.onError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                // Show error to the user
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
        }
        
        viewModel.onSuccess = { [weak self] in
            DispatchQueue.main.async {
                // Handle successful registration
                // Example: Navigate to another screen
                self?.viewModel.coordinator?.start()
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
    
