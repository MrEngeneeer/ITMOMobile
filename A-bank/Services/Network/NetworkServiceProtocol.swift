//
//  NetworkServiceProtocol.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 14.04.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void)
}

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case serverError(statusCode: Int, message: String)
    case noData
    case decodingFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Неверный URL-адрес"
        case .requestFailed(let error):
            return "Ошибка запроса: \(error.localizedDescription)"
        case .invalidResponse:
            return "Некорректный ответ сервера"
        case .serverError(let code, let message):
            return "Ошибка сервера (\(code)): \(message)"
        case .noData:
            return "Данные отсутствуют"
        case .decodingFailed(let error):
            return "Ошибка парсинга: \(error.localizedDescription)"
        }
    }
}
