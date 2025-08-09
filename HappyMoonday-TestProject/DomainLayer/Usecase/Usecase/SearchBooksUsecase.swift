//
//  SearchBooksUsecase.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

import Foundation
import Combine

final class SearchBooksUsecase {
    private(set) var errorSubject = PassthroughSubject<Error, Never>()
    
    private let repository: SearchBooksRepositoryProtocol
    
    init(repository: SearchBooksRepositoryProtocol) {
        self.repository = repository
    }
}

extension SearchBooksUsecase: SearchBooksUsecaseProtocol {
    func searchBooks(with requestModel: Book.Request) async throws -> Book.Entity {
        do {
            return try await repository.searchBooks(with: requestModel)
        } catch {
            errorSubject.send(error)
            throw error
        }
    }
    
    func saveRecentSearchKeyword(_ keyword: String) throws {
        do {
            try repository.saveRecentSearchKeyword(keyword)
        } catch {
            errorSubject.send(error)
            throw error
        }
    }
    
    func fetchRecentKeywords() -> [String] {
         repository.fetchRecentSearchKeywords()
     }
    
    func getErrorSubject() -> AnyPublisher<Error, Never> {
        return errorSubject.eraseToAnyPublisher()
    }
}
