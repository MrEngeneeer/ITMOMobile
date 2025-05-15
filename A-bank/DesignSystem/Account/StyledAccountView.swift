//
//  Account.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 04.05.2025.
//

import UIKit

public final class StyledAccountView: UIView {
    private var viewModel: StyledAccountViewModel!

    private let titleLabel = UILabel()
    private let balanceLabel = UILabel()

    public init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8

        [titleLabel, balanceLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            balanceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            balanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            balanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            balanceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) not supported") }

    public func configure(with vm: StyledAccountViewModel) {
        self.viewModel = vm
        titleLabel.text = vm.accountType
        balanceLabel.text = "Баланс: \(vm.balance) \(vm.currency)"

        switch vm.style {
        case .filledRed:
            backgroundColor = .red
            titleLabel.textColor = .white
            balanceLabel.textColor = .white
            layer.borderWidth = 0
        case .outlinedRed:
            backgroundColor = .white
            layer.borderWidth = 1
            layer.borderColor = UIColor.red.cgColor
            titleLabel.textColor = .red
            balanceLabel.textColor = .red
        case .filledGray:
            backgroundColor = .gray
            titleLabel.textColor = .white
            balanceLabel.textColor = .white
            layer.borderWidth = 0
        }
    }
}
