//
//  TextFieldViewModel.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 04.05.2025.
//

import UIKit

public struct TextFieldViewModel {
    public enum Style: String {
        case filledGray
        case outlinedRed
        case disabledGray  
    }

    public let placeholder: String
    public let style: Style
    public let text: String?
    public let isEnabled: Bool

    public init(
        placeholder: String,
        style: Style,
        text: String? = nil,
        isEnabled: Bool = true
    ) {
        self.placeholder = placeholder
        self.style = style
        self.text = text
        self.isEnabled = isEnabled
    }
}
