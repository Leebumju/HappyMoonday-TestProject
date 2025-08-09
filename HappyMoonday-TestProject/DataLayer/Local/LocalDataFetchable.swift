//
//  LocalDataFetchable.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/8/25.
//

import Foundation

protocol LocalDataFetchable: AnyObject {
//    func saveBooks(_ books: [Book.Entity]) throws
//    func fetchBooks() -> [Book.Entity]
//    func deleteBook(id: ObjectId) throws
    
    
    // MARK: - 검색어
    func saveRecentSearchKeyword(_ keyword: String) throws
    func fetchRecentSearchKeywords() -> [String]
}
