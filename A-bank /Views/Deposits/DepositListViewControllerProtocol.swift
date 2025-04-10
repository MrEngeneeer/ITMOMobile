//
//  DepositListViewControllerProtocol.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 27.03.2025.
//

// Список вкладов
protocol DepositListViewControllerProtocol: AnyObject {
    func reloadDeposits()
    func showNewDepositForm()
    func showDepositDetails(for depositId: String)
    func showDepositStatus(message: String)
}
