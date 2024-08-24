//
//  LoginController.swift
//  AstroTalk
//
//  Created by Aisha on 27.07.24.
//

import UIKit

class LoginController: UIViewController {

    var viewModel: LoginViewModel?
    var coordinator : AppCoordinator
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
  

    init(viewModel: LoginViewModel, coordinator: AppCoordinator) {
            self.viewModel = viewModel
            self.coordinator = coordinator
            super.init(nibName: nil, bundle: nil)
        }

        // Required initializer for storyboard
        required init?(coder: NSCoder) {
            self.viewModel = LoginViewModel()  // Default initialization
            // Initialize with a default or dummy UINavigationController
            let defaultNavigationController = UINavigationController()
            self.coordinator = AppCoordinator(navigationController: defaultNavigationController)
            super.init(coder: coder)
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        coordinator.start()
        
    }
    
    @IBAction func loginTappedButton(_ sender: Any) {
        guard let username = usernameTextField.text, !username.isEmpty,
                      let password = passwordTextField.text, !password.isEmpty else {
                    showAlert(title: "Error", message: "Username and password are required.")
                    return
                }
                
                loginUser(username: username, password: password)
            }
    
    @IBAction func signupTappedButton(_ sender: Any) {
        coordinator.navigateToRegister()
    }

    
    func loginUser(username: String, password: String) {
        guard let url = URL(string: "https://yourapi.com/login") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let credentials = ["username": username, "password": password]
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(credentials)
            request.httpBody = jsonData
        } catch {
            print("Error encoding credentials: \(error)")
            showAlert(title: "Error", message: "Failed to login. Please try again.")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error with login: \(error)")
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: "Failed to login. Please try again.")
                }
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("No data or invalid response received")
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: "Failed to login. Please try again.")
                }
                return
            }
            
            if response.statusCode == 200 {
                print("Login successful")
                DispatchQueue.main.async {
                    self.showAlert(title: "Success", message: "Login successful!")
                    self.coordinator.navigateToHome()
                }
            } else {
                print("Login failed with status code: \(response.statusCode)")
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: "Failed to login. Please check your credentials.")
                }
            }
        }

        task.resume()
    }
    
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    func configure(with viewModel: LoginViewModel) {
           self.viewModel = viewModel
       }
    }
    

