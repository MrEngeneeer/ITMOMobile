//
//  CollectionManagerProtocol.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 01.05.2025.
//
import UIKit

protocol CollectionManagerProtocol: AnyObject {
    func setupCollectionView(_ collectionView: UICollectionView)
    func reloadData()
}
