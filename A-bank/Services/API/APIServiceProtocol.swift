//
//  APIServiceProtocol.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 14.04.2025.
//

protocol APIServiceProtocol {
    func fetchAccounts(completion: @escaping (Result<ViewType, Error>) -> Void)
    func fetchDeposits(page: Int, completion: @escaping (Result<[Deposit], Error>) -> Void)
    func fetchLoans(page: Int, completion: @escaping (Result<[Loan], Error>) -> Void)
    func fetchUser(completion: @escaping (Result<User, Error>) -> Void)
}
