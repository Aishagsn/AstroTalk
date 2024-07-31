//
//  RegisterViewModel.swift
//  AstroTalk
//
//  Created by Aisha on 31.07.24.
//

import Foundation

class RegisterViewModel {
    var onError: ((String) -> Void)?
    var onSuccess: (() -> Void)?
    
    func registerUser(user: User) {
        guard let url = URL(string: "https://yourapi.com/register") else {
            onError?("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(user)
            request.httpBody = jsonData
        } catch {
            onError?("Error encoding user data: \(error.localizedDescription)")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                self?.onError?("Error with registration: \(error.localizedDescription)")
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                self?.onError?("Registration failed.")
                return
            }

            self?.onSuccess?()
        }

        task.resume()
    }
}
