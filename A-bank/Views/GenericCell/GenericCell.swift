//
//  GenericCell.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 30.04.2025.
//
import UIKit


class GenericCell<View: ConfigurableView>: UICollectionViewCell {
    let customView = View()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: View.ViewModel) {
        customView.configure(with: viewModel)
    }
}
