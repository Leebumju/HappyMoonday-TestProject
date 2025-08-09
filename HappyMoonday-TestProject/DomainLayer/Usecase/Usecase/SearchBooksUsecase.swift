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
    
    func getErrorSubject() -> AnyPublisher<Error, Never> {
        return errorSubject.eraseToAnyPublisher()
    }
}
