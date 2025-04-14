//
//  AuthViewController.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 10.04.2025.
//
import UIKit

class AuthViewController: UIViewController, AuthViewControllerProtocol {
    private let viewModel: AuthViewModelProtocol
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Логин"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var authButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.addTarget(self, action: #selector(didTapAuthButton), for: .touchUpInside)
        return button
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    // MARK: - Lifecycle
    
    init(viewModel: AuthViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [
            loginTextField,
            passwordTextField,
            authButton,
            loadingIndicator
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
    
    private func setupBindings() {
        viewModel.onAuthSuccess = { [weak self] in
            self?.proceedToDashboard()
        }
        
        viewModel.onAuthError = { [weak self] message in
            self?.showError(message: message)
        }
    }
    
    // MARK: - Actions
    
    @objc private func didTapAuthButton() {
        guard let login = loginTextField.text,
              let password = passwordTextField.text else {
            showError(message: "Заполните все поля")
            return
        }
        
        showLoadingIndicator(true)
        viewModel.authenticate(login: login, password: password)
    }
    
    // MARK: - AuthViewControllerProtocol
    
    func showLoadingIndicator(_ show: Bool) {
        show ? loadingIndicator.startAnimating() : loadingIndicator.stopAnimating()
        authButton.isEnabled = !show
    }
    
    func showError(message: String) {
        let alert = UIAlertController(
            title: "Ошибка",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func proceedToDashboard() {
        print("Успешный переход в дашборд")
        // Здесь будет навигация к экрану с фичами
    }
}
