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
    
    private func createRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if let token = authService.authToken {
            let credentials = token.data(using: .utf8)!.base64EncodedString()
            request.addValue("Basic \(credentials)", forHTTPHeaderField: "Authorization")
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
    
    func fetchAccounts(page: Int, completion: @escaping (Result<[Account], Error>) -> Void) {
        guard handleAuthCheck(completion: completion) else { return }
        let url = Endpoint.accounts(page: page).url
        let request = createRequest(url: url)
        networkService.fetch(request: request) { (result: Result<AccountsResponse, NetworkError>) in
            switch result {
            case .success(let response):
                let allAccounts = response.accounts
                            
                let startIndex = (page - 1) * 5
                guard startIndex >= 0 && startIndex < allAccounts.count else {
                    completion(.success([]))
                    return
                }
                
                let endIndex = min(startIndex + 5, allAccounts.count)
                let paginatedAccounts = Array(allAccounts[startIndex..<endIndex])
                
                completion(.success(paginatedAccounts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchDeposits(page: Int, completion: @escaping (Result<[Deposit], Error>) -> Void) {
        guard handleAuthCheck(completion: completion) else { return }
        
        let url = Endpoint.deposits(page: page).url
        let request = createRequest(url: url)
        networkService.fetch(request: request) { (result: Result<DepositsResponse, NetworkError>) in
            switch result {
            case .success(let response):
                let allDeposits = response.deposits
                            
                let startIndex = (page - 1) * 5
                guard startIndex >= 0 && startIndex < allDeposits.count else {
                    completion(.success([]))
                    return
                }
                
                let endIndex = min(startIndex + 5, allDeposits.count)
                let paginatedDeposits = Array(allDeposits[startIndex..<endIndex])
                completion(.success(paginatedDeposits))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchLoans(page: Int, completion: @escaping (Result<[Loan], Error>) -> Void) {
        guard handleAuthCheck(completion: completion) else { return }
        
        let url = Endpoint.loans(page: page).url
        let request = createRequest(url: url)
        networkService.fetch(request: request) { (result: Result<LoansResponse, NetworkError>) in
            switch result {
            case .success(let response):
                let allLoans = response.loans
                            
                let startIndex = (page - 1) * 5
                guard startIndex >= 0 && startIndex < allLoans.count else {
                    completion(.success([]))
                    return
                }
                
                let endIndex = min(startIndex + 5, allLoans.count)
                let paginatedLoans = Array(allLoans[startIndex..<endIndex])
                completion(.success(paginatedLoans))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchUser(completion: @escaping (Result<User, any Error>) -> Void) {
        guard handleAuthCheck(completion: completion) else { return }
        
        let url = Endpoint.user.url
        let request = createRequest(url: url)
        networkService.fetch(request: request) { (result: Result<User, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
