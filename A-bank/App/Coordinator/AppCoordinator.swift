//
//  AppCoordinator.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 30.04.2025.
//

import UIKit

final class AppCoordinator: AppCoordinatorProtocol {
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let apiService: APIServiceProtocol
    private let authService: AuthServiceProtocol
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.window.rootViewController = navigationController
        self.authService = LocalAuthService()
        self.apiService = APIService(authService: self.authService)
    }
    
    func start() {
        if UserDefaults.standard.bool(forKey: "isAuthenticated") {
            showDashboard()
        } else {
            showAuth()
        }
        window.makeKeyAndVisible()
    }
    
    func showAuth() {
        let authVM = AuthViewModel(authService: self.authService)
        let authVC = AuthViewController(viewModel: authVM)
        
        authVM.onAuthSuccess = { [weak self] in
            self?.showDashboard()
        }
        
        navigationController.setViewControllers([authVC], animated: true)
    }
    
    func showDashboard() {
        let dashboardVM = DashboardViewModel(apiService: self.apiService)
        let dashboardVC = DashboardViewController(viewModel: dashboardVM)
        dashboardVM.onNavigateToAccounts = { [weak self] in
            self?.showAccountsList()
        }
        
        dashboardVM.onNavigateToDeposits = { [weak self] in
            self?.showDepositList()
        }
        
        dashboardVM.onNavigateToLoans = { [weak self] in
            self?.showLoanList()
        }
        
        navigationController.setViewControllers([dashboardVC], animated: true)
    }
            
    func showAccountsList() {
        let accountVM = AccountViewModel(apiService: self.apiService)
        let accountVC = AccountListViewController(viewModel: accountVM)
        
        navigationController.setViewControllers([accountVC], animated: true)
    }
    
    func showAccountDetails(accountId: String) {
        
    }
    
    func showDepositList() {
        
    }
    
    func showLoanList() {
        
    }

}
