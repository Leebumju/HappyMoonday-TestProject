//
//  LibraryRepositoryProtocol.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

protocol LibraryRepositoryProtocol: AnyObject {
    func fetchBooks(in categoryName: BookCategory) -> [Book.Entity.BookItem]
}
