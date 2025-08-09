//
//  LibraryUsecase.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

import Foundation
import Combine

final class LibraryUsecase {
    private(set) var errorSubject = PassthroughSubject<Error, Never>()
    
    private let repository: LibraryRepositoryProtocol
    
    init(repository: LibraryRepositoryProtocol) {
        self.repository = repository
    }
}

extension LibraryUsecase: LibraryUsecaseProtocol {
    func fetchBooks(in categoryName: BookCategory) -> [Book.Entity.BookItem] {
        return repository.fetchBooks(in: categoryName)
    }
    
    func getErrorSubject() -> AnyPublisher<Error, Never> {
        return errorSubject.eraseToAnyPublisher()
    }
}
