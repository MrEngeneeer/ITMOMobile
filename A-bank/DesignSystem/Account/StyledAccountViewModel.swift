//
//  StyledAccountViewModel.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 04.05.2025.
//

import UIKit

public struct StyledAccountViewModel {
    public enum Style: String {
        case filledRed
        case outlinedRed
        case filledGray
    }

    public let accountType: String
    public let balance: String
    public let style: Style
    public let currency: String

    public init(
        accountType: String,
        balance: String,
        currency: String,
        style: Style
    ) {
        self.accountType = accountType
        self.balance = balance
        self.style = style
        self.currency = currency
    }
}
