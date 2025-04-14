//
//  AuthViewModel.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 10.04.2025.
//

class AuthViewModel: AuthViewModelProtocol {
    var onAuthSuccess: (() -> Void)?
    var onAuthError: ((String) -> Void)?
    
    func authenticate(login: String, password: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if login == "admin" && password == "password" {
                self.onAuthSuccess?()
            } else {
                self.onAuthError?("Неверный логин или пароль")
            }
        }
    }
}
