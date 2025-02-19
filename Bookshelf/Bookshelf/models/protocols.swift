//
//  model.swift
//  BookShelf
//
//  Created by Vladimir Ganetski on 19.02.2025.
//
import Foundation
protocol LibraryItem {
    var id: UUID { get }
    var title: String { get }
    var author: String { get }
    var publicationYear: Int? { get }
    func identitify(by criteria: String) -> Bool
    func constructInTerminal()
    func showInfo()
}

enum Genre: String, CaseIterable{
    case fiction = "Fiction"
    case nonFiction = "Non-Fiction"
    case mystery = "Mystery"
    case sciFi = "SciFi"
    case biography = "Biography"
}

protocol Library {
    func addBook(_ book: LibraryItem)
    func removeBook(by id: UUID) throws
    func listBooks() -> [LibraryItem]
    func searchBooks(by criteria: String) -> [LibraryItem]
}

enum LibraryError: Error{
    case bookNotFound
    case invalidInput
}
