//
//  SearchBooksUsecaseProtocol.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

protocol SearchBooksUsecaseProtocol: BaseUsecaseProtocol {
    // MARK: - REMOTE
    func searchBooks(with requestModel: Book.Request) async throws -> Book.Entity
    
    // MARK: - LOCAL
    func saveRecentSearchKeyword(_ keyword: String) throws
    func fetchRecentKeywords() -> [String]
    func changeBookCategory(_ bookEntity: Book.Entity.BookItem, to category: BookCategory) throws
    func fetchBooks(in categoryName: BookCategory) -> [Book.Entity.BookItem]
}
