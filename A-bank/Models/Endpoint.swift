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
    
    case accounts(page: Int)
    case deposits(page: Int)
    case loans(page: Int)
    
    private var baseURL: String { "https://your-api.com/" }
    
    var url: URL {
        switch self {
        case .auth:
            return URL(string: "\(baseURL)auth")!
        case .register:
            return URL(string: "\(baseURL)register")!
        case .accounts(let page):
            return URL(string: "\(baseURL)accounts?page=\(page)")!
        case .deposits(let page):
            return URL(string: "\(baseURL)deposits?page=\(page)")!
        case .loans(let page):
            return URL(string: "\(baseURL)loans?page=\(page)")!
        }
    }
}
