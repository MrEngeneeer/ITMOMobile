//
//  User.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 27.03.2025.
//

// Пользователь
struct User {
    let id: String
    let name: String
    let accounts: [Account]
    let deposits: [Deposit]
    let loans: [Loan]
}
