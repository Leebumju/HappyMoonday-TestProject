//
//  SearchBooksRepositoryProtocol.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

protocol SearchBooksRepositoryProtocol: AnyObject {
    // MARK: - Remote
    func searchBooks(with requestModel: Book.Request) async throws -> Book.Entity
    
    // MARK: - Local
    func saveRecentSearchKeyword(_ keyword: String) throws
    func fetchRecentSearchKeywords() -> [String]
    
    func changeBookCategory(_ bookEntity: Book.Entity.BookItem, to category: BookCategory) throws
}
