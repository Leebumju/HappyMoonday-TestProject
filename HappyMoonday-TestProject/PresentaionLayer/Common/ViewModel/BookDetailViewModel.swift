//
//  BookDetailViewModel.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

import Foundation
import Combine

final class BookDetailViewModel: BaseViewModel {
    private let usecase: SearchBooksUsecaseProtocol
    private(set) var bookInfo: Book.Entity.BookItem

    init(usecase: SearchBooksUsecaseProtocol, bookInfo: Book.Entity.BookItem) {
        self.usecase = usecase
        self.bookInfo = bookInfo
        
        super.init(usecase: usecase)
    }
    
    func changeBookCategory(_ bookEntity: Book.Entity.BookItem, to category: BookCategory) throws {
        do {
            try usecase.changeBookCategory(bookEntity, to: category)
        } catch { throw error }
    }
}
