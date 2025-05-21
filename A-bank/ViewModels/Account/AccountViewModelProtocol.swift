//
//  AccountViewModelProtocol.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 27.03.2025.
//
import UIKit

protocol AccountViewModelProtocol {
    var onViewReady: ((UIView) -> Void)? { get set }
    var onLoadingError: ((String) -> Void)? { get set }
    func fetchScreen()
}

