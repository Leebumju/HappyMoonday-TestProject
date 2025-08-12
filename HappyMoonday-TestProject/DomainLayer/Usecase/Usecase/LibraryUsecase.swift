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
    
    func changeBookCategory(_ bookEntity: Book.Entity.BookItem, to category: BookCategory) throws {
        do {
            try repository.changeBookCategory(bookEntity, to: category)
        } catch {
            errorSubject.send(error)
            throw error
        }
    }

    func noteBook(with bookEntity: Book.Entity.BookItem) throws {
        do {
            try repository.changeBookCategory(bookEntity, to: .noted)
        } catch {
            throw error
        }
    }
    
    func deleteBookInCategory(book: Book.Entity.BookItem, in category: BookCategory) throws {
        do {
            try repository.deleteBookInCategory(book: book, in: category)
        } catch {
            throw error
        }
    }
    
    func getErrorSubject() -> AnyPublisher<Error, Never> {
        return errorSubject.eraseToAnyPublisher()
    }
}
