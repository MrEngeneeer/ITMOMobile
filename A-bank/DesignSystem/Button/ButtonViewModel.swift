//
//  ButtonViewModel.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 04.05.2025.
//

import UIKit

public struct ButtonViewModel {
    public enum Style: String {
        case primary
        case secondary
        case destructive     
    }

    public let title: String
    public let style: Style
    public let isEnabled: Bool
    public let onTap: (() -> Void)?

    public init(
        title: String,
        style: Style,
        isEnabled: Bool = true,
        onTap: (() -> Void)? = nil
    ) {
        self.title = title
        self.style = style
        self.isEnabled = isEnabled
        self.onTap = onTap
    }
}
