//
//  AccountDetailViewControllerProtocol.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 27.03.2025.
//

// Детали счета
protocol AccountDetailViewControllerProtocol: AnyObject {
    func displayAccountInfo(type: String, balance: String, currency: String)
    func showTransactionHistory(_ transactions: [String])
    func showAccountActions()
}
