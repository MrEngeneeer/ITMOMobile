//
//  AccountView.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 01.05.2025.
//

import UIKit

class AccountView: UIView, ConfigurableView {
    typealias ViewModel = Account
    
    private let titleLabel = UILabel()
    private let balanceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .red
        layer.cornerRadius = 12
        
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.textColor = .white
        balanceLabel.font = .preferredFont(forTextStyle: .body)
        balanceLabel.textColor = .white
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, balanceLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with viewModel: Account) {
        titleLabel.text = viewModel.type.rawValue
        balanceLabel.text = "Баланс: \(viewModel.balance) \(viewModel.currency)"
    }
}
