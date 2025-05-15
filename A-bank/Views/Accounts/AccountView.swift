//
//  AccountView.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 01.05.2025.
//

import UIKit

class AccountView: UIView, ConfigurableView {
    typealias ViewModel = Account
    
    private var accountView = StyledAccountView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        accountView.configure(with: .init(accountType: "", balance: "", currency: "", style: .filledRed))
        
        addSubview(accountView)
        
        NSLayoutConstraint.activate([
            accountView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            accountView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            accountView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            accountView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with viewModel: Account) {
        accountView.configure(with: .init(accountType: viewModel.type.rawValue, balance: "\(viewModel.balance)", currency: "\(viewModel.currency)", style: .filledRed))

    }
}
