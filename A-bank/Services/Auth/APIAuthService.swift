//
//  APIAuthService.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 14.04.2025.
//

import Foundation

final class AuthService: AuthServiceProtocol {
    
    private let tokenKey = "userAuthToken"
    private var token: String? {
        get { UserDefaults.standard.string(forKey: tokenKey) }
        set { UserDefaults.standard.set(newValue, forKey: tokenKey) }
    }
    
    var authToken: String? { return token }
    var isAuthenticated: Bool { return token != nil }
    

    func authenticate(login: String, password: String, completion: @escaping (Result<Void, AuthError>) -> Void) {
        let url = Endpoint.auth.url
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "login": login,
            "password": password
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.networkError))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.unknownError))
                    return
                }
                
                switch httpResponse.statusCode {
                case 200:
                    if let data = data,
                       let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let token = json["token"] as? String {
                        self?.token = token
                        completion(.success(()))
                    } else {
                        completion(.failure(.invalidCredentials))
                    }
                case 401:
                    completion(.failure(.invalidCredentials))
                default:
                    completion(.failure(.serverError(message: "Код ошибки: \(httpResponse.statusCode)")))
                }
            }
        }.resume()
    }
    
    func register(email: String, password: String, completion: @escaping (Result<Void, AuthError>) -> Void) {
        let url = Endpoint.register.url
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "email": email,
            "password": password
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.networkError))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.unknownError))
                    return
                }
                
                switch httpResponse.statusCode {
                case 201:
                    completion(.success(()))
                case 409:
                    completion(.failure(.userAlreadyExists))
                default:
                    completion(.failure(.serverError(message: "Код ошибки: \(httpResponse.statusCode)")))
                }
            }
        }.resume()
    }
    

    func logout() {
        token = nil
    }
}
