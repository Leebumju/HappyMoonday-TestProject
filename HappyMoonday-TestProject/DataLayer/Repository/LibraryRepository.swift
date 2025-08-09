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
    func searchBooks(with requestModel: Book.Request) async throws -> Book.Entity {
        return try await remoteDataFetcher.searchBooks(with: requestModel)
    }
}
