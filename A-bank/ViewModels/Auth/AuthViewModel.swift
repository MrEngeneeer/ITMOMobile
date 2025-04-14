//
//  AuthViewModel.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 10.04.2025.
//

import Foundation

class AuthViewModel: AuthViewModelProtocol {
    var onAuthSuccess: (() -> Void)?
    var onAuthError: ((String) -> Void)?
    private let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func validateEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func validatePassword(_ password: String) -> Bool {
        return password.count >= 6
    }
    
    
    
    func authenticate(login: String, password: String) {
        authService.authenticate(login: login, password: password) { [weak self] result in
           
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.onAuthSuccess?()
                case .failure(let error):
                    let message = self?.errorMessage(for: error) ?? "Неизвестная ошибка"
                    self?.onAuthError?(message)
                }
            }
        }
    }
    
    private func errorMessage(for error: AuthError) -> String {
        switch error {
        case .invalidCredentials: return "Неверный логин или пароль"
        case .networkError: return "Ошибка сети"
        default: return "Ошибка сервера"
        }
    }
}
