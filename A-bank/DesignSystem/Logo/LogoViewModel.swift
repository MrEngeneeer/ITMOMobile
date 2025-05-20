//
//  LogoViewModel.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 04.05.2025.
//

import UIKit

public struct LogoViewModel {

    public enum Color: String {
        case light
        case primary
        case dark     
    }


    public let size: CGSize


    public let color: Color


    public let lineWidth: CGFloat

    public init(
        size: CGSize = CGSize(width: 100, height: 100),
        color: Color = .primary,
        lineWidth: CGFloat = 4
    ) {
        self.size = size
        self.color = color
        self.lineWidth = lineWidth
    }
}
