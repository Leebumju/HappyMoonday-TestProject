//
//  NoteUsecase.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/11/25.
//

import Foundation
import Combine

final class NoteUsecase {
    private(set) var errorSubject = PassthroughSubject<Error, Never>()
    
    private let repository: NoteRepositoryProtocol
    
    init(repository: NoteRepositoryProtocol) {
        self.repository = repository
    }
}

extension NoteUsecase: NoteUsecaseProtocol {
    func fetchBooks(in categoryName: BookCategory) -> [Book.Entity.BookItem] {
        return repository.fetchBooks(in: categoryName)
    }
    
    func noteBook(with bookEntity: Book.Entity.BookItem) throws {
        do {
            try repository.changeBookCategory(bookEntity, to: .noted)
        } catch {
            throw error
        }
    }
    
    func getErrorSubject() -> AnyPublisher<Error, Never> {
        return errorSubject.eraseToAnyPublisher()
    }
}
