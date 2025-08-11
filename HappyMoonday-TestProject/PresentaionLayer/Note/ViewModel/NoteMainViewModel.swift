//
//  Untitled.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/11/25.
//

import Combine
import Foundation

final class NoteMainViewModel: ObservableObject {
    @Published var notedBooks: [Book.Entity.BookItem] = []
    private let usecase: NoteUsecaseProtocol
    
    init(usecase: NoteUsecaseProtocol) {
        self.usecase = usecase
    }
    
    func fetchNotedBooks() {
        notedBooks = usecase.fetchBooks(in: .noted)
    }
}
