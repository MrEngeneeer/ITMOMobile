//
//  main.swift
//  BookShelf
//
//  Created by Vladimir Ganetski on 17.02.2025.
//



import Foundation

let bookShelf = BookShelf()

while true {
    print("""
    Выберите действие:
    1. Добавить книгу
    2. Удалить книгу
    3. Показать все книги
    4. Найти книгу
    5. Выйти
    """)

    if let input = readLine(), let choice = Int(input) {
        switch choice {
        case 1:
            print("""
            Выберите тип книги:
            1. Книга
            2. Учебник
            3. Комикс
            """)
            
            if let typeString = readLine(), let typeIndex = Int(typeString){
                var newBook: LibraryItem
                switch typeIndex {
                case 1:
                    newBook = Book()
                case 2:
                    newBook = Textbook()
                case 3:
                    newBook = Comic()
                default:
                    print("Неверный тип книги.")
                    continue
                }
                
                newBook.constructInTerminal()
                
                bookShelf.addBook(newBook)
                
            } else {
                print("Неверный ввод.")
                continue
            }

        case 2:
            print("Введите ID книги для удаления:")
            guard let idString = readLine(), let id = UUID(uuidString: idString) else {
                print("Неверный формат ID.")
                continue
            }

            do {
                try bookShelf.removeBook(by: id)
                print("Книга успешно удалена!")
            } catch LibraryError.bookNotFound {
                print("Книга с таким ID не найдена.")
            } catch {
                print("Произошла ошибка: \(error)")
            }

        case 3:
            let books = bookShelf.listBooks()
            if books.isEmpty {
                print("В библиотеке пока нет книг.")
            } else {
                print("Список книг:")
                for book in books {
                    book.showInfo()
                    print()
                }
            }

        case 4:
            print("Введите критерий поиска (название или автор):")
            guard let criteria = readLine(), !criteria.isEmpty else {
                print("Критерий поиска не может быть пустым.")
                continue
            }

            let foundBooks = bookShelf.searchBooks(by: criteria)
            if foundBooks.isEmpty {
                print("Книги по вашему запросу не найдены.")
            } else {
                print("Найденные книги:")
                for book in foundBooks {
                    book.showInfo()
                }
            }

        case 5:
            print("Выход из программы...")
            exit(0)

        default:
            print("Неверный выбор. Попробуйте снова.")
        }
    } else {
        print("Неверный ввод. Попробуйте снова.")
    }
}
