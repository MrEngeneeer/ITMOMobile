//
//  ViewType.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 15.05.2025.
//

import UIKit

enum ViewType: Decodable {
    case contentView(ContentViewModel)
    case stackView(StackViewModel)
    case label(LabelViewModel)
    case button(ButtonViewModel)

    enum CodingKeys: String, CodingKey {
        case type
    }

    enum ViewTypeName: String, Decodable {
        case contentView, stackView, label, button
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(ViewTypeName.self, forKey: .type)
        switch type {
        case .contentView:
            self = .contentView(try ContentViewModel(from: decoder))
        case .stackView:
            self = .stackView(try StackViewModel(from: decoder))
        case .label:
            self = .label(try LabelViewModel(from: decoder))
        case .button:
            self = .button(try ButtonViewModel(from: decoder))
        }
    }
}
