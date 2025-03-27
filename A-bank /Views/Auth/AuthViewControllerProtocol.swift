//
//  AuthViewControllerProtocol.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 27.03.2025.
//

// Экран аутентификации
protocol AuthViewControllerProtocol: AnyObject {
    func showLoadingIndicator(_ show: Bool)
    func showError(message: String)
    func proceedToDashboard()
}
