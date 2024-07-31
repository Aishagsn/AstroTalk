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
    
    func loginUser(username: String, password: String) {
        guard let url = URL(string: "https://yourapi.com/login") else {
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

            self?.onSuccess?()
        }

        task.resume()
    }
}
