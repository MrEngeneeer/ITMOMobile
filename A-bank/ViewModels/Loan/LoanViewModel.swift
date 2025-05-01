//
//  LoanViewModel.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 14.04.2025.
//

import Foundation

class LoanViewModel: LoanViewModelProtocol {
    var loans: [Loan] = []
    var onDataUpdated: (() -> Void)?
    private let apiService: APIServiceProtocol
    private var currentPage = 1
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchLoans() {
        apiService.fetchLoans(page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let newLoans):
                    self?.loans.append(contentsOf: newLoans)
                    self?.onDataUpdated?()
                case .failure(let error):
                    print("Ошибка: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func nextPage() {
        currentPage = currentPage + 1
        fetchLoans()
    }
}
