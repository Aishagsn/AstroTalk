//
//  LoginController.swift
//  AstroTalk
//
//  Created by Aisha on 27.07.24.
//

import UIKit

class LoginController: UIViewController {
    
    var viewModel: LoginViewModel?
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
//    init(viewModel: LoginViewModel, usernameTextField: UITextField!, passwordTextField: UITextField!) {
//        self.viewModel = viewModel
//        self.usernameTextField = usernameTextField
//        self.passwordTextField = passwordTextField
//    }
//    
//      required init?(coder: NSCoder) {
//          fatalError("init(coder:) has not been implemented. Use the custom initializer instead.")
//      }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        viewModel?.coordinator?.navigateToRegister()
    }
    
    
//    func loginUser(username: String, password: String) {
//        guard let url = URL(string: "http://35.223.201.116:8088/api/auth/login") else { return }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        let credentials = ["userName": username, "password": password]
//        let encoder = JSONEncoder()
//        do {
//            let jsonData = try encoder.encode(credentials)
//            request.httpBody = jsonData
//        } catch {
//            print("Error encoding credentials: \(error)")
//            showAlert(title: "Error", message: "Failed to login. Please try again.")
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Error with login: \(error)")
//                DispatchQueue.main.async {
//                    self.showAlert(title: "Error", message: "Failed to login. Please try again.")
//                }
//                return
//            }
//            guard let data = data, let response = response as? HTTPURLResponse else {
//                print("No data or invalid response received")
//                DispatchQueue.main.async {
//                    self.showAlert(title: "Error", message: "Failed to login. Please try again.")
//                }
//                return
//            }
//            
//            if response.statusCode == 200 {
//                print("Login successful")
//                DispatchQueue.main.async {
//                    self.showAlert(title: "Success", message: "Login successful!")
//                    self.viewModel?.coordinator?.navigateToHome()
//                }
//            } else {
//                print("Login failed with status code: \(response.statusCode)")
//                DispatchQueue.main.async {
//                    self.showAlert(title: "Error", message: "Failed to login. Please check your credentials.")
//                }
//            }
//        }
//        
//        task.resume()
//    }
    func loginUser(username: String, password: String) {
        guard let url = URL(string: "http://35.223.201.116:8088/api/auth/login") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let credentials = ["userName": username, "password": password]
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
                do {
                    // Decode the response to extract the token
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let accessToken = jsonResponse["accessToken"] as? String {
                        
                        // Store the token securely, here using UserDefaults for simplicity
                        UserDefaults.standard.set(accessToken, forKey: "accessToken")
                        
                        print("Login successful, token stored: \(accessToken)")
                        
                        DispatchQueue.main.async {
                            self.showAlert(title: "Success", message: "Login successful!")
                            self.viewModel?.coordinator?.navigateToHome()
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.showAlert(title: "Error", message: "Failed to parse login response.")
                        }
                    }
                } catch {
                    print("Error parsing response data: \(error)")
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error", message: "Failed to login. Please try again.")
                    }
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


