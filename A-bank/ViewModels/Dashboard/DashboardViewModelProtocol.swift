//
//  DashboardViewModelProtocol.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 27.03.2025.
//

protocol DashboardViewModelProtocol {
    var user: User { get }
    var onDataUpdated: (() -> Void)? { get set }
    var onNavigateToAccounts: (() -> Void)? { get set }
    var onNavigateToDeposits: (() -> Void)? { get set }
    var onNavigateToLoans: (() -> Void)? { get set }
    
    func navigateToAccounts()
    func navigateToDeposits()
    func navigateToLoans()
    
    func fetchUserData()
}
