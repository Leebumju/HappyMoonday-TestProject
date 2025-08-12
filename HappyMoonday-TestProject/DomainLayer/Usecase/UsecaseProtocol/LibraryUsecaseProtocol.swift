//
//  LibraryUsecaseProtocol.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

protocol LibraryUsecaseProtocol: BaseUsecaseProtocol {
    func fetchBooks(in categoryName: BookCategory) -> [Book.Entity.BookItem]
    func changeBookCategory(_ bookEntity: Book.Entity.BookItem, to category: BookCategory) throws
    func deleteBookInCategory(book: Book.Entity.BookItem, in category: BookCategory) throws
}
