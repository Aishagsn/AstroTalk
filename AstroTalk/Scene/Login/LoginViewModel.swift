//
//  LoginViewModel.swift
//  AstroTalk
//
//  Created by Aisha on 31.07.24.
//

import Foundation

class LoginViewModel {
    var onError: ((String) -> Void)?
    var onSuccess: (() -> Void)?
    var coordinator: AppCoordinator?
    
    // Initialize with coordinator
    init(coordinator: AppCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func loginUser(username: String, password: String) {
        guard let url = URL(string: "http://localhost:5000/api/login") else {
            onError?("Invalid URL")
            return
        }


        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let credentials = ["username": username, "password": password]
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
            }

            // On success, use the coordinator to navigate to the home screen
            self?.onSuccess?()
            self?.coordinator?.navigateToHome()
        }

        task.resume()
    }
}
