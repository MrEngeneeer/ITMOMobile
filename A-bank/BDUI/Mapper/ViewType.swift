//
//  ViewType.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 15.05.2025.
//

import UIKit

enum ViewType: Decodable {
    case contentView(ContentModel)
    case stackView(StackModel)
    case label(LabelModel)
    case button(ButtonModel)
    case textField(TextFieldModel)
    case logo(LogoModel)
    case styledAccount(StyledAccountModel)
    case scrollView(ScrollModel)

    enum CodingKeys: String, CodingKey {
        case type
    }

    enum ViewTypeName: String, Decodable {
        case contentView
        case stackView
        case label
        case button
        case textField
        case logo
        case styledAccount
        case scrollView
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(ViewTypeName.self, forKey: .type)
        switch type {
        case .contentView:
            self = .contentView(try ContentModel(from: decoder))
        case .stackView:
            self = .stackView(try StackModel(from: decoder))
        case .label:
            self = .label(try LabelModel(from: decoder))
        case .button:
            self = .button(try ButtonModel(from: decoder))
        case .textField:
            self = .textField(try TextFieldModel(from: decoder))
        case .logo:
            self = .logo(try LogoModel(from: decoder))
        case .styledAccount:
            self = .styledAccount(try StyledAccountModel(from: decoder))
        case .scrollView:
            self = .scrollView(try ScrollModel(from: decoder))
        }
    }
}
