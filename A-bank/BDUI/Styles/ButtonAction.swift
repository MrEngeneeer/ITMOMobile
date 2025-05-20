//
//  ButtonAction.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 15.05.2025.
//

struct ButtonAction: Decodable {
    let type: String
    let textFieldIDs: [String]?
    let endpoint: String?
    let httpMethod: String?
}
