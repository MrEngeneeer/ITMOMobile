//
//  ConfigurableView.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 30.04.2025.
//
import UIKit

protocol ConfigurableView: UIView {
    associatedtype ViewModel
    func configure(with viewModel: ViewModel)
}
