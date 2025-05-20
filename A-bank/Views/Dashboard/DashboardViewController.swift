//
//  DashboardViewController.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 30.04.2025.
//

import UIKit

class DashboardViewController: UIViewController, DashboardViewControllerProtocol {
    private var viewModel: DashboardViewModelProtocol
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    
    private let accountsSection = Button()
    private let depositsSection = Button()
    private let loansSection = Button()
    
    init(viewModel: DashboardViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.onDataUpdated = { [weak self] in
            self?.displayUserInfo(name: viewModel.user.name)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchUserData()
        accountsSection.addTarget(self, action: #selector(accountButtonTaped), for: .touchUpInside)
        depositsSection.addTarget(self, action: #selector(depositButtonTaped), for: .touchUpInside)
        loansSection.addTarget(self, action: #selector(loanButtonTaped), for: .touchUpInside)
        setupUI()
        
    }
    
    private func setupUI() {
        accountsSection.configure(with: .init(title: "Счета", style: .primary))
        depositsSection.configure(with: .init(title: "Вклады", style: .primary))
        loansSection.configure(with: .init(title: "Кредиты", style: .primary))
        view.backgroundColor = .red
        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)
        contentStack.addArrangedSubview(nameLabel)
        contentStack.addArrangedSubview(accountsSection)
        contentStack.addArrangedSubview(depositsSection)
        contentStack.addArrangedSubview(loansSection)
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
    }
    
    func displayUserInfo(name: String) {
        nameLabel.text = name
    }
    
    @objc func accountButtonTaped() {
        self.viewModel.onNavigateToAccounts!()
    }
    
    @objc func depositButtonTaped() {
        self.viewModel.onNavigateToDeposits!()
    }
    
    @objc func loanButtonTaped() {
        self.viewModel.onNavigateToLoans!()
    }
}
