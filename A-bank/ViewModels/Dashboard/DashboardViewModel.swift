//
//  DashboardViewModel.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 30.04.2025.
//
import Foundation

class DashboardViewModel: DashboardViewModelProtocol {
    var user: User
    var onDataUpdated: (() -> Void)?
    var onNavigateToAccounts: (() -> Void)?
    var onNavigateToDeposits: (() -> Void)?
    var onNavigateToLoans: (() -> Void)?
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
        self.user = User(id: "", name: "")
    }
    
    func navigateToAccounts() {
        self.onNavigateToAccounts?()
    }
    
    func navigateToDeposits() {
        self.onNavigateToDeposits?()
    }
    
    func navigateToLoans() {
        self.onNavigateToLoans?()
    }
    
    func fetchUserData() {
        apiService.fetchUser { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.user = user
                    self?.onDataUpdated?()
                case .failure:
                    break
                }
            }
        }
    }
}
