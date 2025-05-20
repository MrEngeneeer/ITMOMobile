//
//  BackButton.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 04.05.2025.
//

import UIKit

public final class BackButton: UIButton {
    private var viewModel: BackButtonViewModel!

    public init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: 24).isActive = true
        heightAnchor.constraint(equalToConstant: 24).isActive = true
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) not supported") }

    public func configure(with vm: BackButtonViewModel) {
        self.viewModel = vm

        let systemName: String
        switch vm.direction {
        case .left:  systemName = "chevron.left"
        case .right: systemName = "chevron.right"
        }

        let img = UIImage(systemName: systemName)
        setImage(img, for: .normal)
        tintColor = vm.isActive ? .red : UIColor.lightGray.withAlphaComponent(0.5)
        isUserInteractionEnabled = vm.isActive
    }

    @objc private func didTap() {
        viewModel.onTap?()
    }
}
