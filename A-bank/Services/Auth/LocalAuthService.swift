//
//  AuthService.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 10.04.2025.
//

import Foundation

class LocalAuthService: AuthServiceProtocol {
    
    private let userDefaults = UserDefaults.standard
    private let usersKey = "storedUsers"
    
    private var currentUser: String? {
        get { userDefaults.string(forKey: "currentUser") }
        set { userDefaults.set(newValue, forKey: "currentUser") }
    }
    
    private var users: [String: String] {
        get {
            guard let data = userDefaults.data(forKey: usersKey),
                  let dictionary = try? JSONDecoder().decode([String: String].self, from: data)
            else { return [:] }
            return dictionary
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else { return }
            userDefaults.set(data, forKey: usersKey)
        }
    }
    
    init() {
        guard !users.keys.contains("admin@mail.ru") else { return }
        
        var newUsers = users
        newUsers["admin@mail.ru"] = "admin1"
        users = newUsers
    }

    
    var isAuthenticated: Bool {
        return currentUser != nil
    }
    
    var authToken: String? {
        return "368011:qklLRlkYW4do"
    }
    
    func authenticate(login: String,
                     password: String,
                     completion: @escaping (Result<Void, AuthError>) -> Void) {
        
        DispatchQueue.global().asyncAfter(deadline: .now()) {
            let storedPassword = self.users[login]
            guard let storedPassword = storedPassword else {
                return completion(.failure(.invalidCredentials))
            }
            
            guard storedPassword == password else {
                return completion(.failure(.invalidCredentials))
            }
            
            self.currentUser = login
            completion(.success(()))
        }
    }
    
    func register(email: String,
                 password: String,
                 completion: @escaping (Result<Void, AuthError>) -> Void) {
        
        guard !users.keys.contains(email) else {
            return completion(.failure(.userAlreadyExists))
        }
        
        var newUsers = users
        newUsers[email] = password
        users = newUsers
        
        completion(.success(()))
    }
    
    func logout() {
        currentUser = nil
    }
}
