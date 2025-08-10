//
//  LibraryRepository.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

import Foundation

final class LibraryRepository {
    private let remoteDataFetcher: RemoteDataFetchable
    private let localDataFetcher: LocalDataFetchable
    
    init(remoteDataFetcher: RemoteDataFetchable, localDataFetcher: LocalDataFetchable) {
        self.remoteDataFetcher = remoteDataFetcher
        self.localDataFetcher = localDataFetcher
    }
}

extension LibraryRepository: LibraryRepositoryProtocol {
    func fetchBooks(in categoryName: BookCategory) -> [Book.Entity.BookItem] {
        return localDataFetcher.fetchBooks(in: categoryName)
    }
    func changeBookCategory(_ bookEntity: Book.Entity.BookItem, to category: BookCategory) throws {
        try localDataFetcher.changeBookCategory(bookEntity, to: category)
    }
}
