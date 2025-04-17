//
//  DashboardViewModelProtocol.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 27.03.2025.
//

protocol DashboardViewModelProtocol {
    var user: User { get }
    var onDataUpdated: (() -> Void)? { get set }
    func fetchUserData()
    func navigateToAccounts()
    func navigateToDeposits()
    func navigateToLoans()
}
