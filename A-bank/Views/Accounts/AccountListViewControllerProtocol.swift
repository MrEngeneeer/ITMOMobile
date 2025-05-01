//
//  AccountListViewControllerProtocol.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 27.03.2025.
//

// Список счетов
protocol AccountListViewControllerProtocol: AnyObject {
    func reloadAccounts()
    func showLoadingError(message: String)
}
