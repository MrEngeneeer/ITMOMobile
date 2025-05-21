//
//  Endpoint.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 14.04.2025.
//

import Foundation

// Шаблон для эндпоинта (чтобы не переписывать ссылки, если что-то поменяется)
enum Endpoint {
    case auth
    case register
    case user
    
    case accounts
    case deposits(page: Int)
    case loans(page: Int)
    
    private var baseURL: String { "https://alfa-itmo.ru/server/v1/storage" }
    
    var url: URL {
        switch self {
        case .auth:
            return URL(string: "\(baseURL)/auth")!
        case .register:
            return URL(string: "\(baseURL)/register")!
        case .accounts:
            return URL(string: "\(baseURL)/accounts")!
        case .deposits(let page):
            return URL(string: "\(baseURL)/deposits?page=\(page)&per_page=5")!
        case .loans(let page):
            return URL(string: "\(baseURL)/loans?page=\(page)&per_page=5")!
        case .user:
            return URL(string: "\(baseURL)/user")!
        }
    }
}
