//
//  SearchBooksRepository.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

import Foundation

final class SearchBooksRepository {
    private let remoteDataFetcher: RemoteDataFetchable
    private let localDataFetcher: LocalDataFetchable
    
    init(remoteDataFetcher: RemoteDataFetchable, localDataFetcher: LocalDataFetchable) {
        self.remoteDataFetcher = remoteDataFetcher
        self.localDataFetcher = localDataFetcher
    }
}

extension SearchBooksRepository: SearchBooksRepositoryProtocol {
    func searchBooks(with requestModel: Book.Request) async throws -> Book.Entity {
        return try await remoteDataFetcher.searchBooks(with: requestModel)
    }
    
    func saveRecentSearchKeyword(_ keyword: String) throws {
        try localDataFetcher.saveRecentSearchKeyword(keyword)
    }
    
    func fetchRecentSearchKeywords() -> [String] {
        return localDataFetcher.fetchRecentSearchKeywords()
    }
    
    func changeBookCategory(_ bookEntity: Book.Entity.BookItem, to category: BookCategory) throws {
        try localDataFetcher.changeBookCategory(bookEntity, to: category)
    }
}
