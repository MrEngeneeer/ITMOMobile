//
//  AppCoordinatorProtocol.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 30.04.2025.
//

protocol AppCoordinatorProtocol: AnyObject {
    func start()
    func showAuth()
    func showDashboard()
    func showAccountsList()
    func showDepositList()
    func showLoanList()
}
