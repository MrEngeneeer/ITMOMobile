//
//  LoanViewModelProtocol.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 27.03.2025.
//

protocol LoanViewModelProtocol {
    var loans: [Loan] { get }
    var onDataUpdated: (() -> Void)? { get set }
    func fetchLoans()
    func nextPage()
}
