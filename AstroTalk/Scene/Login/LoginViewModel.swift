//
//  LoginViewModel.swift
//  AstroTalk
//
//  Created by Aisha on 31.07.24.
//

import Foundation
import UIKit

class LoginViewModel {
    var onError: ((String) -> Void)?
    var onSuccess: (() -> Void)?
   
    func loginUser(username: String, password: String) {
        guard let url = URL(string: "http://35.223.201.116:8088/api/auth/login") else {
            onError?("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let credentials = ["userName": username, "password": password]
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(credentials)
            request.httpBody = jsonData
        } catch {
            onError?("Error encoding credentials: \(error.localizedDescription)")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                self?.onError?("Error with login: \(error.localizedDescription)")
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                self?.onError?("Login failed.")
                return
            }

            // Assuming the API returns the JWT token in the response body
            if let data = data, let token = String(data: data, encoding: .utf8) {
                // Store the JWT token securely (e.g., in Keychain)
                print("JWT Token: \(token)")
                
                // After successful login, call the updateUser function
                self?.updateUser(with: token)
            }
        }

        task.resume()
    }
    
    func updateUser(with token: String) {
        guard let url = URL(string: "http://localhost:8088/api/user/updateUser") else {
            onError?("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization") // Attach the token in the header

        // Assuming the user data to update is provided
        let updatedUser = ["name": "New Name", "email": "newemail@example.com"]
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(updatedUser)
            request.httpBody = jsonData
        } catch {
            onError?("Error encoding user data: \(error.localizedDescription)")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                self?.onError?("Error with updating user: \(error.localizedDescription)")
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                self?.onError?("User update failed.")
                return
            }

            // Successfully updated user, proceed with further actions
            self?.onSuccess?()
            self?.navigateToHome()
        }

        task.resume()
    }

    func navigateToHome() {
        DispatchQueue.main.async {
            // Access the SceneDelegate
            if let sceneDelegate = UIApplication.shared.connectedScenes
                .first?.delegate as? SceneDelegate {
                // Instantiate the HomeViewController
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
                    // Set the root view controller to HomeViewController
                    let navController = UINavigationController(rootViewController: homeVC)
                    sceneDelegate.window?.rootViewController = navController
                    sceneDelegate.window?.makeKeyAndVisible()
                }
            }
        }
    }
}
