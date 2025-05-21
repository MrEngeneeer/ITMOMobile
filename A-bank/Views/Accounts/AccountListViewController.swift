//
//  AccountViewController.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 01.05.2025.
//
import UIKit

class AccountListViewController: UIViewController, AccountListViewControllerProtocol {
    
    private var viewModel: AccountViewModelProtocol
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    init(viewModel: AccountViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModelBindings()
        loadInitialScreen()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupViewModelBindings() {
        viewModel.onViewReady = { [weak self] screenView in
            guard let self = self else { return }
            self.loadingIndicator.stopAnimating()
            
            self.view.addSubview(screenView)
            screenView.translatesAutoresizingMaskIntoConstraints = false
            
            
            NSLayoutConstraint.activate([
                screenView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                screenView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                screenView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                screenView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
            
        }
        
        viewModel.onLoadingError = { [weak self] message in
            guard let self = self else { return }
            self.loadingIndicator.stopAnimating()
            self.showLoadingError(message: message)
        }
    }
    
    private func loadInitialScreen() {
        loadingIndicator.startAnimating()
        viewModel.fetchScreen()
    }
    
    func showLoadingError(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
