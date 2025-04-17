//
//  AuthServiceProtocol.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 10.04.2025.
//
import Foundation

/// Протокол для сервиса аутентификации
protocol AuthServiceProtocol {
    

    func authenticate(
        login: String,
        password: String,
        completion: @escaping (Result<Void, AuthError>) -> Void
    )
    

    func register(
        email: String,
        password: String,
        completion: @escaping (Result<Void, AuthError>) -> Void
    )
    

    func logout()
    
    var authToken: String? { get }

    var isAuthenticated: Bool { get }
}

enum AuthError: Error {
    case invalidCredentials
    case userAlreadyExists
    case networkError
    case serverError(message: String)
    case unknownError
}
