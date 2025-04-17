//
//  AccountViewModel.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 14.04.2025.
//

import Foundation

class AccountViewModel: AccountViewModelProtocol {
    
    var accounts: [Account] = []
    var onDataUpdated: (() -> Void)?
    private let apiService: APIServiceProtocol
    private var currentPage = 1
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchAccounts() {
        apiService.fetchAccounts(page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let newAccounts):
                    self?.accounts.append(contentsOf: newAccounts)
                    self?.onDataUpdated?()
                case .failure(let error):
                    print("Ошибка: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func selectAccount(id: String) {
        print("Выбран аккаунт с ID: \(id)")
    }
    
    func nextPage() {
        currentPage = currentPage + 1
        fetchAccounts()
    }
    
}
