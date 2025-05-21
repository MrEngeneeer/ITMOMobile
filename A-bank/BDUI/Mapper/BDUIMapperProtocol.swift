//
//  BDUIMapperProtocol.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 15.05.2025.
//
import UIKit

protocol BDUIMapperProtocol {
    func makeView(from viewType: ViewType) -> UIView
}
