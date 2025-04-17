//
//  DepositViewModelProtocol.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 27.03.2025.
//

protocol DepositViewModelProtocol {
    var deposits: [Deposit] { get }
    var onDataUpdated: (() -> Void)? { get set }
    func fetchDeposits()
    func nextPage()
}
