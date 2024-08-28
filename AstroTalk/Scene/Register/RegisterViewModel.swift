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
    
    init(coordinator: AppCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func registerUser(user: User) {
        guard let url = URL(string: "http://localhost:5000/api/auth/register") else {
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
        
        // Create a custom URLSession configuration
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30.0
        
        let sessionDelegate = CustomSessionDelegate()
        let session = URLSession(configuration: sessionConfig, delegate: sessionDelegate, delegateQueue: nil)
        
        //        let task = session.dataTask(with: request) { [weak self] data, response, error in
        //            if let error = error {
        //                self?.onError?("Error with registration: \(error.localizedDescription)")
        //                return
        //            }
        //
        //            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        //                self?.onError?("Registration failed.")
        //                return
        //            }
        //
        //            self?.onSuccess?()
        //            self?.coordinator?.start() // Placeholder for the actual navigation function
        //        }
        //
        //        task.resume()
        //    }
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                self?.onError?("Error with registration: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                self?.onError?("Invalid response.")
                return
            }
            
            let statusCode = response.statusCode
            if statusCode == 200 {
                self?.onSuccess?()
                self?.coordinator?.start() // Placeholder for the actual navigation function
            } else {
                let responseString = String(data: data ?? Data(), encoding: .utf8) ?? "No response data"
                self?.onError?("Registration failed with status code \(statusCode): \(responseString)")
            }
        }
    }
        
        
        // Custom URLSession delegate to bypass SSL validation
        class CustomSessionDelegate: NSObject, URLSessionDelegate {
            func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
                if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                    completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
                } else {
                    completionHandler(.performDefaultHandling, nil)
                }
            }
        }
        
    }

