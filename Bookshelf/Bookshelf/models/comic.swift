//
//  comic.swift
//  BookShelf
//
//  Created by Vladimir Ganetski on 19.02.2025.
//
import Foundation
class Comic: LibraryItem {
    let id: UUID = UUID()
    var title: String = ""
    var author: String = ""
    var publicationYear: Int? = nil
    var issueNumber: Int = 0
    func identitify(by criteria: String) -> Bool {
        if let unwrappedPublicationYear = publicationYear{
            if String(unwrappedPublicationYear) == criteria{
                return true
            }
        }
        return id.uuidString == criteria || title == criteria || author == criteria || String(issueNumber) == criteria
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
        
        print("Введите номер выпуска:")
        while true {
            guard let issueInput = readLine(), let issueIndex = Int(issueInput), issueIndex > 0
            else {
                print("Неверный номер выпуска.")
                continue
            }
            self.issueNumber = issueIndex
            break
        }
        
    }
    
    func showInfo() {
        print("""
        ID: \(self.id)
        Название: \(self.title)
        Автор: \(self.author)
        Год издания: \(self.publicationYear ?? -1)
        Номер выпуска: \(self.issueNumber)
        """)
    }
    
}
