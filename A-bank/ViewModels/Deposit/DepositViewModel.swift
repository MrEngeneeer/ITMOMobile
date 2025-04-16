//
//  DepositViewModel.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 14.04.2025.
//

import Foundation

class DepositViewModel: DepositViewModelProtocol {
    var deposits: [Deposit] = []
    var onDataUpdated: (() -> Void)?
    private let apiService: APIServiceProtocol
    private var currentPage = 1
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchDeposits() {
        apiService.fetchDeposits(page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let newDeposits):
                    self?.deposits.append(contentsOf: newDeposits)
                    self?.onDataUpdated?()
                case .failure(let error):
                    print("Ошибка: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func nextPage() {
        currentPage = currentPage + 1
        fetchDeposits()
    }
    
    func prevPage() {
        if currentPage > 1{
            currentPage = currentPage - 1
        }
        fetchDeposits()
    }
}
