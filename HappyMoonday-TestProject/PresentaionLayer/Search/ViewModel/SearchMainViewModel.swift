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
    var currentPage: Int = 1
    var totalItems: Int = 0
    var isLoading: Bool = false
    let itemsPerPage: Int = 10
    var storedKeyword: String = ""
    
    private var allSearchedBooks: [Book.Entity.BookItem] = []
    
    private let searchedBooksSubject = CurrentValueSubject<Book.Entity, Never>(.init())
    var searchedBooks: Book.Entity {
        return searchedBooksSubject.value
    }
    var searchedBooksPublisher: AnyPublisher<Book.Entity, Never> {
        return searchedBooksSubject.eraseToAnyPublisher()
    }
    
    private let recentKeywordSubject = CurrentValueSubject<[String], Never>([])
    var recentKeywordPublisher: AnyPublisher<[String], Never> {
        return recentKeywordSubject.eraseToAnyPublisher()
    }
    
    init(usecase: SearchBooksUsecaseProtocol) {
        self.usecase = usecase
        super.init(usecase: usecase)
    }
    
    func searchBooks(with keyword: String) async throws {
        guard !isLoading else { return }
        guard !keyword.isEmpty else { return }
        
        if storedKeyword != keyword {
            currentPage = 1
            totalItems = 0
            allSearchedBooks = []
        }
        
        if totalItems != 0 && allSearchedBooks.count >= totalItems {
            return
        }
        isLoading = true
         defer { isLoading = false }
        
        do {
            searchBookRequestModel.query = keyword
            searchBookRequestModel.start = (currentPage - 1) * itemsPerPage + 1
            searchBookRequestModel.display = itemsPerPage
            
            let response = try await usecase.searchBooks(with: searchBookRequestModel)
            
            if currentPage == 1 {
                allSearchedBooks = response.items
            } else {
                allSearchedBooks.append(contentsOf: response.items)
            }
            
            totalItems = response.total
            currentPage += 1
            
            let entity = Book.Entity(
                lastBuildDate: response.lastBuildDate,
                total: response.total,
                start: response.start,
                display: response.display,
                items: allSearchedBooks
            )
            searchedBooksSubject.send(entity)
            
            try saveRecentSearchKeyword(with: keyword)
            fetchRecentSearchKeyword()
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
