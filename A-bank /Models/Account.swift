//
//  Account.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 27.03.2025.
//

// Счет
enum AccountType {
    case debit
    case credit
}

struct Account {
    let id: String
    let type: AccountType
    let balance: Double
    let currency: String
}
