//
//  LoanListViewControllerProtocol.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 27.03.2025.
//

// Список кредитов
protocol LoanListViewControllerProtocol: AnyObject {
    func reloadLoans()
    func showLoanApplicationForm()
    func showLoanDetails(for loanId: String)
    func showPaymentStatus(message: String)
}
