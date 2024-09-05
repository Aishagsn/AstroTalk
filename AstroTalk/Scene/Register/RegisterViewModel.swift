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
    
    var coordinator: AppCoordinator?
    
    // Custom initializer with coordinator
    init(coordinator: AppCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    // Function to validate registration data
    func validateRegistration(name: String?, surname: String?, userName: String?, email: String?, password: String?) -> Bool {
        guard let name = name, name.count >= 2, name.count <= 64 else { return false }
        guard let surname = surname, surname.count >= 2, surname.count <= 64 else { return false }
        guard let userName = userName, userName.count >= 2, userName.count <= 16 else { return false }
        guard let email = email, email.contains("@") else { return false }
        guard let password = password, password.count >= 6 else { return false } // Adjust based on actual password policy
        return true
    }

    func registerUser(name: String?, surname: String?, userName: String?, email: String?, password: String?, phone: String?) {
        // Validate user data before making the API request
        guard validateRegistration(name: name, surname: surname, userName: userName, email: email, password: password) else {
            onError?("Validation failed. Please check your input.")
            return
        }

        guard let url = URL(string: "http://35.223.201.116:8088/api/auth/register") else {
            onError?("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: String?] = [
            "firstName": name,
            "lastName": surname,
            "userName": userName,
            "email": email,
            "phone": phone,
            "password": password
        ]
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(parameters)
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

            guard let response = response as? HTTPURLResponse else {
                self?.onError?("Invalid response from server.")
                return
            }

            switch response.statusCode {
            case 200:
                self?.onSuccess?()
//                self?.coordinator?.start() // Navigate to another screen or handle successful registration
            case 201:
                self?.onSuccess?()
//                self?.coordinator?.start()                
            case 400:
                self?.onError?("Bad Request: Please check your input data.")
            case 401:
                self?.onError?("Unauthorized: Authentication failed.")
            case 500:
                self?.onError?("Server Error: Please try again later.")
            default:
                self?.onError?("Unexpected error occurred. Status code: \(response.statusCode)")
            }
        }

        task.resume()
    }
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                if let serverTrust = challenge.protectionSpace.serverTrust {
                    completionHandler(.useCredential, URLCredential(trust: serverTrust))
                } else {
                    completionHandler(.performDefaultHandling, nil)
                }
            } else {
                completionHandler(.performDefaultHandling, nil)
            }
        }
    }

