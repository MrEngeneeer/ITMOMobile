//
//  CollectionManagerDelegate.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 01.05.2025.
//
import UIKit

protocol CollectionManagerDelegate<ItemType>: AnyObject {
    associatedtype ItemType
    var numberOfItems: Int { get }
    func item(at indexPath: IndexPath) -> ItemType
    func didScrollToBottom()
    func didSelectItem(at indexPath: IndexPath)
}
