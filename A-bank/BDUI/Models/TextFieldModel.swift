//
//  TextFieldModel.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 15.05.2025.
//

struct TextFieldModel : Decodable{
    let id: String
    let text: String?
    let style: TextFieldStyle
}
