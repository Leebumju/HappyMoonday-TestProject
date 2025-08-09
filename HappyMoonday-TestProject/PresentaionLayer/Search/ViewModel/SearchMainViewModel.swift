//
//  SearchMainViewModel.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

import Foundation
import Combine

final class SearchBooksMainViewModel: BaseViewModel {
    private let usecase: SearchBooksUsecaseProtocol
    private var searchBookRequestModel: Book.Request = .init(query: "동물",
                                                             display: nil,
                                                             start: nil,
                                                             sort: nil)
    private let searchedBooksSubject = CurrentValueSubject<Book.Entity?, Never>(nil)
    var searchedBooks: Book.Entity? {
        return searchedBooksSubject.value
    }
    var searchedBooksPublisher: AnyPublisher<Book.Entity?, Never> {
        return searchedBooksSubject.eraseToAnyPublisher()
    }
    
    init(usecase: SearchBooksUsecaseProtocol) {
        self.usecase = usecase
        super.init(usecase: usecase)
    }
    
    func searchBooks() async throws {
        do {
            let searchedBooks = try await usecase.searchBooks(with: searchBookRequestModel)
            searchedBooksSubject.send(searchedBooks)
            print(">>>>>vm")
            print(searchedBooks)
        } catch { throw error }
    }
}
