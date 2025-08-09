//
//  LibraryMainViewModel.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

import Foundation
import Combine

final class LibraryMainViewModel: BaseViewModel {
    private let usecase: LibraryUsecaseProtocol
    
    private(set) var readingBooks: [Book.Entity.BookItem] = []
    private(set) var wantToReadBooks: [Book.Entity.BookItem] = []
    private(set) var readDoneBooks: [Book.Entity.BookItem] = []
    
    private let allBooksSubject = CurrentValueSubject<Void, Never>(())
    var allBooksPublisher: AnyPublisher<Void, Never> {
        return allBooksSubject.eraseToAnyPublisher()
    }

    init(usecase: LibraryUsecaseProtocol) {
        self.usecase = usecase
        super.init(usecase: usecase)
    }
    
    func fetchAllBooksCategory() {
        readingBooks = usecase.fetchBooks(in: .reading)
        wantToReadBooks = usecase.fetchBooks(in: .wantToRead)
        readDoneBooks = usecase.fetchBooks(in: .readDone)
        
        allBooksSubject.send(())
    }
}
