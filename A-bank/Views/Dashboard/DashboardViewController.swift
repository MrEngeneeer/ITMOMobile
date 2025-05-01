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

    
    private let accountsSection = DashboardSectionView(title: "Счета")
    private let depositsSection = DashboardSectionView(title: "Депозиты")
    private let loansSection = DashboardSectionView(title: "Кредиты")
    
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
        accountsSection.onItemTap = { [weak self] in
            self?.viewModel.navigateToAccounts()
        }
        depositsSection.onItemTap = { [weak self] in
            self?.viewModel.navigateToDeposits()
        }
        loansSection.onItemTap = { [weak self] in
            self?.viewModel.navigateToLoans()
        }
        setupUI()
        
    }
    
    private func setupUI() {
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
}
