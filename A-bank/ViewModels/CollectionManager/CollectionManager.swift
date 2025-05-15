//
//  CollectionManager.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 01.05.2025.
//
import UIKit

private enum Constants {
    static let cellIdentifier = "GenericCell"
    static let cellHeight: CGFloat = 100
    static let horizontalInset: CGFloat = 32
}

final class CollectionManager<ViewType: ConfigurableView, ItemType>: NSObject,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
where ViewType.ViewModel == ItemType {

    private weak var collectionView: UICollectionView?
    weak var delegate: (any CollectionManagerDelegate<ItemType>)?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        delegate?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.cellIdentifier,
            for: indexPath
        ) as? GenericCell<ViewType>,
              let item = delegate?.item(at: indexPath) else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
            width: collectionView.bounds.width - Constants.horizontalInset,
            height: Constants.cellHeight
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            delegate?.didScrollToBottom()
        }
    }
}

extension CollectionManager: CollectionManagerProtocol {
    func setupCollectionView(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        collectionView.register(
            GenericCell<ViewType>.self,
            forCellWithReuseIdentifier: Constants.cellIdentifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func reloadData() {
        collectionView?.reloadData()
    }
}

