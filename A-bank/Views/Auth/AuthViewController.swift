//
//  AuthViewController.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 10.04.2025.
//
import UIKit

class AuthViewController: UIViewController, AuthViewControllerProtocol {
    private var viewModel: AuthViewModelProtocol
    private var activeTextField: UITextField?
    private var scrollViewBottomConstraint: NSLayoutConstraint!
    
    // MARK: - UI Elements
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.keyboardDismissMode = .interactive
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.delegate = self
        textField.addTarget(self, action: #selector(emailDidChange), for: .editingChanged)
        return textField
    }()
    
    private lazy var loginErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 12)
        label.isHidden = true
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.addTarget(self, action: #selector(passwordDidChange), for: .editingChanged)
        return textField
    }()
    
    private lazy var passwordErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 12)
        label.isHidden = true
        return label
    }()
    
    private lazy var authButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
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
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = .all
        
        setupUI()
        setupKeyboardObservers()
        setupTapGesture()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .red
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let stackView = UIStackView(arrangedSubviews: [
            loginTextField,
            loginErrorLabel,
            passwordTextField,
            passwordErrorLabel,
            authButton,
            loadingIndicator
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.setCustomSpacing(16, after: passwordErrorLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let topBackground = UIView()
        topBackground.backgroundColor = .red
        topBackground.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBackground)
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            stackView.topAnchor.constraint(greaterThanOrEqualTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            stackView.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor),
            
            topBackground.topAnchor.constraint(equalTo: view.topAnchor),
            topBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBackground.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
                
        ])
    }
    
    private func setupBindings() {
        viewModel.onAuthSuccess = { [weak self] in
            self?.showLoadingIndicator(false)
            self?.proceedToDashboard()
        }
        
        viewModel.onAuthError = { [weak self] message in
            self?.showLoadingIndicator(false)
            self?.showError(message: message)
        }
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions
    @objc private func didTapAuthButton() {
        guard validateInputs() else { return }
        
        guard let email = loginTextField.text,
              let password = passwordTextField.text else {
            showError(message: "Заполните все поля")
            return
        }
        
        showLoadingIndicator(true)
        viewModel.authenticate(login: email, password: password)
    }
    
    @objc private func emailDidChange() {
        validateEmail()
        updateButtonState()
    }
    
    @objc private func passwordDidChange() {
        validatePassword()
        updateButtonState()
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentInset.bottom = keyboardHeight
            self.scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight
        }
    }
    
    @objc private func keyboardWillHide() {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentInset = .zero
            self.scrollView.verticalScrollIndicatorInsets = .zero
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Validation
    private func validateInputs() -> Bool {
        let isEmailValid = validateEmail()
        let isPasswordValid = validatePassword()
        return isEmailValid && isPasswordValid
    }
    
    @discardableResult
    private func validateEmail() -> Bool {
        guard let email = loginTextField.text else { return false }
        let isValid = viewModel.validateEmail(email)
        
        if isValid {
            loginErrorLabel.isHidden = true
            loginTextField.layer.borderColor = UIColor.clear.cgColor
        } else {
            loginErrorLabel.text = "Неверный формат email"
            loginErrorLabel.textColor = .white
            loginErrorLabel.isHidden = false
            loginTextField.layer.borderWidth = 1
            loginTextField.layer.borderColor = UIColor.red.cgColor
        }
        
        return isValid
    }
    
    @discardableResult
    private func validatePassword() -> Bool {
        guard let password = passwordTextField.text else { return false }
        let isValid = viewModel.validatePassword(password)
        
        if isValid {
            passwordErrorLabel.isHidden = true
            passwordTextField.layer.borderColor = UIColor.clear.cgColor
        } else {
            passwordErrorLabel.text = "Пароль должен содержать минимум 6 символов"
            loginErrorLabel.textColor = .white
            passwordErrorLabel.isHidden = false
            passwordTextField.layer.borderWidth = 1
            passwordTextField.layer.borderColor = UIColor.red.cgColor
        }
        
        return isValid
    }
    
    private func updateButtonState() {
        let isFormValid = !(loginTextField.text?.isEmpty ?? true) &&
                         !(passwordTextField.text?.isEmpty ?? true)
        authButton.isEnabled = isFormValid
        authButton.alpha = isFormValid ? 1.0 : 0.5
        authButton.backgroundColor = isFormValid ? .white : .lightGray
        authButton.setTitleColor(isFormValid ? .red : .darkGray, for: .normal)
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
    }
}

// MARK: - UITextFieldDelegate
extension AuthViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
