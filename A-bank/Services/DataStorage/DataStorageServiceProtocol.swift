//
//  DataStorageServiceProtocol.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 27.03.2025.
//

protocol DataStorageProtocol {
    func fetchUser(completion: @escaping (User?) -> Void)
    func fetchAccounts(completion: @escaping ([Account]) -> Void)
    func fetchDeposits(completion: @escaping ([Deposit]) -> Void)
    func fetchLoans(completion: @escaping ([Loan]) -> Void)
}
