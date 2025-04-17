//
//  APIService.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 14.04.2025.
//

import Foundation

class APIService: APIServiceProtocol {
    private let networkService: NetworkServiceProtocol
    private let authService: AuthServiceProtocol
    private let jsonDecoder: JSONDecoder
    
    init(
        networkService: NetworkServiceProtocol = NetworkService(),
        authService: AuthServiceProtocol = AuthService(),
        jsonDecoder: JSONDecoder = JSONDecoder()
    ) {
        self.networkService = networkService
        self.authService = authService
        self.jsonDecoder = jsonDecoder
        jsonDecoder.dateDecodingStrategy = .iso8601
    }
    
    // MARK: - Private Helpers
    private func createRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        if let token = authService.authToken {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
    
    private func handleAuthCheck<T>(completion: (Result<T, Error>) -> Void) -> Bool {
        guard authService.isAuthenticated else {
            completion(.failure(AuthError.invalidCredentials))
            return false
        }
        return true
    }
    
    // MARK: - Public Methods
    func fetchAccounts(page: Int, completion: @escaping (Result<[Account], Error>) -> Void) {
        guard handleAuthCheck(completion: completion) else { return }
        
        let url = Endpoint.accounts(page: page).url
        let request = createRequest(url: url)
        networkService.fetch(request: request) { (result: Result<[Account], NetworkError>) in
                switch result {
                case .success(let accounts):
                    completion(.success(accounts))
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
    
    func fetchDeposits(page: Int, completion: @escaping (Result<[Deposit], Error>) -> Void) {
        guard handleAuthCheck(completion: completion) else { return }
        
        let url = Endpoint.deposits(page: page).url
        let request = createRequest(url: url)
        networkService.fetch(request: request) { (result: Result<[Deposit], NetworkError>) in
                    switch result {
                    case .success(let deposits):
                        completion(.success(deposits))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
    }
    
    func fetchLoans(page: Int, completion: @escaping (Result<[Loan], Error>) -> Void) {
        guard handleAuthCheck(completion: completion) else { return }
        
        let url = Endpoint.loans(page: page).url
        let request = createRequest(url: url)
        networkService.fetch(request: request) { (result: Result<[Loan], NetworkError>) in
                    switch result {
                    case .success(let loans):
                        completion(.success(loans))
                    case .failure(let error):
                        completion(.failure(error)) // NetworkError → Error
                    }
                }
    }
}
