//
//  NoteRepositoryProtocol.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/11/25.
//

protocol NoteRepositoryProtocol: AnyObject {
    func fetchBooks(in categoryName: BookCategory) -> [Book.Entity.BookItem]
    func changeBookCategory(_ bookEntity: Book.Entity.BookItem, to category: BookCategory) throws
}
