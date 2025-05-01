//
//  Account.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 27.03.2025.
//

// Счет
enum AccountType: String, Decodable {
    case debit
    case credit
}

struct Account: Decodable {
    let id: String
    let type: AccountType
    let balance: Double
    let currency: String
}

struct AccountsResponse: Decodable {
    let accounts: [Account]
}
