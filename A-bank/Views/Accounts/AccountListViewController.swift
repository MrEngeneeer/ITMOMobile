//
//  AccountViewController.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 01.05.2025.
//
import UIKit

class AccountListViewController: UIViewController, AccountListViewControllerProtocol {
    
    
    private var viewModel: AccountViewModelProtocol
    private var collectionManager: CollectionManager<AccountView, Account>!
    private let refreshControl = UIRefreshControl()
    private var collectionView: UICollectionView!
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    init(viewModel: AccountViewModelProtocol = AccountViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.collectionManager = CollectionManager<AccountView, Account>()
        (self.collectionManager as? CollectionManager)?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
        loadInitialData()
    }
    
    private func setupUI() {
        title = "Счета"
        view.backgroundColor = .systemBackground
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionManager.setupCollectionView(collectionView)
        
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        loadingIndicator.hidesWhenStopped = true
        
        let stackView = UIStackView(arrangedSubviews: [collectionView, loadingIndicator])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc private func handleRefresh() {
            viewModel.refreshAccounts()
    }
    
    private func setupViewModel() {
        self.viewModel.onDataUpdated = { [weak self] in
            self?.reloadAccounts()
        }
    }
    
    private func loadInitialData() {
        loadingIndicator.startAnimating()
        viewModel.fetchAccounts()
    }

    
    func reloadAccounts() {
        loadingIndicator.stopAnimating()
        refreshControl.endRefreshing()
        collectionView.reloadData()
    }
    
    func showLoadingError(message: String) {
        loadingIndicator.stopAnimating()
        refreshControl.endRefreshing()
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}


extension AccountListViewController: CollectionManagerDelegate {
    var numberOfItems: Int {
        viewModel.accounts.count
    }
    
    func item(at indexPath: IndexPath) -> Account {
        viewModel.accounts[indexPath.row]
    }
    
    func didScrollToBottom() {
        viewModel.nextPage()
    }
    
    func didSelectItem(at indexPath: IndexPath) {
    }
}
