//
//  book.swift
//  BookShelf
//
//  Created by Vladimir Ganetski on 19.02.2025.
//
import Foundation
class Book: LibraryItem {
    let id: UUID = UUID()
    var title: String = ""
    var author: String = ""
    var publicationYear: Int? = nil
    var genre: Genre = Genre.biography
    
    func identitify(by criteria: String) -> Bool {
        if let unwrappedPublicationYear = publicationYear{
            if String(unwrappedPublicationYear) == criteria{
                return true
            }
        }
        return id.uuidString == criteria || title == criteria || author == criteria || genre.rawValue == criteria
    }
    func constructInTerminal() {
        
        print("Введите название книги:")
        while true{
            guard let title = readLine(), !title.isEmpty else {
                print("Название книги не может быть пустым.")
                continue
            }
            self.title = title
            break
        }
        
        print("Введите автора книги:")
        while true{
            guard let author = readLine(), !author.isEmpty else {
                print("Автор книги не может быть пустым.")
                continue
            }
            self.author = author
            break
        }
        
        print("Введите год издания книги (необязательно, нажмите Enter, чтобы пропустить):")
        let yearInput = readLine()
        let publicationYear: Int? = {
            guard let yearInput = yearInput, !yearInput.isEmpty else {
                return nil
            }
            return Int(yearInput)
        }()
        self.publicationYear = publicationYear
        
        print("Выберите жанр книги:")
        for (index, genre) in Genre.allCases.enumerated() {
            print("\(index + 1). \(genre.rawValue)")
        }
        while true {
            guard let genreInput = readLine(), let genreIndex = Int(genreInput), genreIndex > 0, genreIndex <= Genre.allCases.count else {
                print("Неверный выбор жанра.")
                continue
            }
            self.genre = Genre.allCases[genreIndex - 1]
            break
        }
        
    }
    
    func showInfo() {
        print("""
        ID: \(self.id)
        Название: \(self.title)
        Автор: \(self.author)
        Год издания: \(self.publicationYear ?? -1)
        Жанр: \(self.genre.rawValue)
        """)
    }
}

