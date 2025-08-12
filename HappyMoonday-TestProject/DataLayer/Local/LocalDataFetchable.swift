//
//  LocalDataFetchable.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/8/25.
//

import Foundation

protocol LocalDataFetchable: AnyObject {
    // MARK: - 검색어
    func saveRecentSearchKeyword(_ keyword: String) throws
    func fetchRecentSearchKeywords() -> [String]
    
    // MARK: - 책 상태관리
    func changeBookCategory(_ bookEntity: Book.Entity.BookItem, to category: BookCategory) throws
    func deleteBookInCategory(book: Book.Entity.BookItem, in category: BookCategory) throws
    func fetchBooks(in categoryName: BookCategory) -> [Book.Entity.BookItem]
}
