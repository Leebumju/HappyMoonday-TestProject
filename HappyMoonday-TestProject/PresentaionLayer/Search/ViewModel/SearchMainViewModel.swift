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
    
    private let recentKeywordSubject = CurrentValueSubject<[String], Never>([])
//    var recentKeyword: [String] {
//        return recentKeywordSubject.value
//    }
    var recentKeywordPublisher: AnyPublisher<[String], Never> {
        return recentKeywordSubject.eraseToAnyPublisher()
    }
    
    init(usecase: SearchBooksUsecaseProtocol) {
        self.usecase = usecase
        super.init(usecase: usecase)
    }
    
    func searchBooks(with keyword: String) async throws {
        do {
            searchBookRequestModel.query = keyword
            let searchedBooks = try await usecase.searchBooks(with: searchBookRequestModel)
            searchedBooksSubject.send(searchedBooks)
            try saveRecentSearchKeyword(with: keyword)
            fetchRecentSearchKeyword()
            print(">>>>>vm")
            print(searchedBooks)
        } catch { throw error }
    }
    
    private func saveRecentSearchKeyword(with keyword: String) throws {
        do {
            try usecase.saveRecentSearchKeyword(keyword)
        } catch { throw error }
    }
    
    func fetchRecentSearchKeyword() {
        recentKeywordSubject.send(usecase.fetchRecentKeywords())
    }
}
