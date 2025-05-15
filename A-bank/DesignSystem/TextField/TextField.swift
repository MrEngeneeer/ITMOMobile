//
//  TextField.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 04.05.2025.
//

import UIKit

public final class TextField: UITextField {
    private var viewModel: TextFieldViewModel!

    public init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        autocapitalizationType = .none
        layer.cornerRadius = 6
        borderStyle = .none
        heightAnchor.constraint(equalToConstant: 40).isActive = true
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 40))
        leftView = padding
        leftViewMode = .always
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) not supported") }

    public func configure(with vm: TextFieldViewModel) {
        self.viewModel = vm
        placeholder = vm.placeholder
        text = vm.text
        isEnabled = vm.isEnabled

        switch vm.style {
        case .filledGray:
            backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
            textColor = .white
            layer.borderWidth = 0
        case .outlinedRed:
            backgroundColor = .clear
            layer.borderWidth = 1
            layer.borderColor = UIColor.red.cgColor
            textColor = .red
        case .disabledGray:
            backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
            textColor = .white
            layer.borderWidth = 0
        }
    }
}
