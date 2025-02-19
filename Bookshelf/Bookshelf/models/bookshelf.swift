//
//  bookshelf.swift
//  BookShelf
//
//  Created by Vladimir Ganetski on 19.02.2025.
//
import Foundation
class BookShelf: Library{
    private var books: [LibraryItem] = []
    func addBook(_ book: LibraryItem) {
        books.append(book)
    }
    func removeBook(by id: UUID) throws {
        guard let index = books.firstIndex(where: {$0.id == id}) else {
            throw LibraryError.bookNotFound
        }
        books.remove(at: index)
    }
    func listBooks() -> [LibraryItem] {
        return books
    }
    func searchBooks(by criteria: String) -> [LibraryItem] {
        return books.filter({$0.identitify(by: criteria)})
    }
    
    
}
