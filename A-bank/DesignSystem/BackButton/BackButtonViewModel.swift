//
//  BackButtonViewModel.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 04.05.2025.
//

import UIKit

public struct BackButtonViewModel {
    public enum Direction {
        case left
        case right
    }


    public let direction: Direction


    public let isActive: Bool


    public let onTap: (() -> Void)?

    public init(
        direction: Direction,
        isActive: Bool = true,
        onTap: (() -> Void)? = nil
    ) {
        self.direction = direction
        self.isActive = isActive
        self.onTap = onTap
    }
}
