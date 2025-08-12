//
//  NoteBookViewModel.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/11/25.
//

import Combine
import Foundation

final class NoteBookViewModel: ObservableObject {
    @Published var noteBookIsSuccess: Bool = false
    
    private let usecase: NoteUsecaseProtocol
    let bookInfo: Book.Entity.BookItem
    
    init(usecase: NoteUsecaseProtocol, bookInfo: Book.Entity.BookItem) {
        self.usecase = usecase
        self.bookInfo = bookInfo
        print(">>>>>> \(bookInfo)")
    }
    
    func noteBook(startDate: Date, endDate: Date, note: String) throws {
        do {
            var notedBook: Book.Entity.BookItem = bookInfo
            notedBook.startDate = startDate
            notedBook.endDate = endDate
            notedBook.note = note
            notedBook.recordDate = Date()
            
            try usecase.noteBook(with: notedBook)
            noteBookIsSuccess = true
        } catch {
            print(error) // TODO: - 에러처리 구조 변경
        }
    }
}
