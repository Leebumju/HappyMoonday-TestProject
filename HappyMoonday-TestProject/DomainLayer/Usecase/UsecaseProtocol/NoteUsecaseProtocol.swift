//
//  NoteUsecaseProtocol.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/11/25.
//

import Foundation

protocol NoteUsecaseProtocol: BaseUsecaseProtocol {
    func fetchBooks(in categoryName: BookCategory) -> [Book.Entity.BookItem]
    func noteBook(with bookEntity: Book.Entity.BookItem) throws
    func deleteBookInCategory(book: Book.Entity.BookItem, in category: BookCategory) throws
}
