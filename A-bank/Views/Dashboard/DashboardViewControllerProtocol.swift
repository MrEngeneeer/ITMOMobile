//
//  DashboardViewControllerProtocol.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 27.03.2025.
//

// Все доступные функции
protocol DashboardViewControllerProtocol: AnyObject {
    func displayUserInfo(name: String, totalBalance: String)
    func reloadAccountsSection()
    func reloadDepositsSection()
    func reloadLoansSection()
    func showSessionExpiredAlert()
}
