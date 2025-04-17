//
//  Deposit.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 27.03.2025.
//

import Foundation

// Вклад
struct Deposit: Codable {
    let id: String
    let amount: Double
    let interestRate: Double
    let endDate: Date
}
