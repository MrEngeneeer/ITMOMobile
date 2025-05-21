//
//  AccountViewModel.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 14.04.2025.
//

import Foundation
import UIKit

class AccountViewModel: AccountViewModelProtocol {
    
    var onViewReady: ((UIView) -> Void)?
    var onLoadingError: ((String) -> Void)?
    
    private let apiService: APIServiceProtocol
    private let mapper: BDUIMapperProtocol
    
    init(apiService: APIServiceProtocol,
         mapper: BDUIMapperProtocol = DefaultBDUIMapper()) {
        self.apiService = apiService
        self.mapper = mapper
    }
    
    func fetchScreen() {
        apiService.fetchAccounts { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let viewType):
                let viewModel = self.mapper.makeView(from: viewType)
                DispatchQueue.main.async {
                    self.onViewReady?(viewModel)
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.onLoadingError?(error.localizedDescription)
                }
            }
        }
    }
}
