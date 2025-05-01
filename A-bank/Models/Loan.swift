//
//  Loan.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 27.03.2025.
//

// Кредит
struct Loan: Decodable {
    let id: String
    let amount: Double
    let interestRate: Double
    let remainingPayments: Int
}

struct LoansResponse: Decodable {
    let loans: [Loan]
}
