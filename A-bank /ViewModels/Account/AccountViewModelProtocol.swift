//
//  AccountViewModelProtocol.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 27.03.2025.
//

protocol AccountViewModelProtocol {
    var accounts: [Account] { get }
    var onDataUpdated: (() -> Void)? { get set }
    func fetchAccounts()
    func selectAccount(id: String)
}
