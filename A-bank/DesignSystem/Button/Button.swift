//
//  Button.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 04.05.2025.
//

import UIKit

public final class Button: UIButton {
    private var viewModel: ButtonViewModel!

    public init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
        titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        heightAnchor.constraint(equalToConstant: 44).isActive = true
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) not supported") }

    public func configure(with vm: ButtonViewModel) {
        self.viewModel = vm
        setTitle(vm.title, for: .normal)
        isEnabled = vm.isEnabled

        switch vm.style {
        case .primary:
            backgroundColor = .white
            setTitleColor(.red, for: .normal)
            layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowRadius = 4
            layer.shadowOpacity = 1
        case .destructive:
            backgroundColor = .darkGray
            setTitleColor(.lightGray, for: .normal)
            layer.shadowOpacity = 0
        case .secondary:
            backgroundColor = .red
            setTitleColor(.white, for: .normal)
            layer.shadowOpacity = 0
        }

        alpha = vm.isEnabled ? 1 : 0.5
    }

    @objc private func didTap() {
        viewModel.onTap?()
    }
}
