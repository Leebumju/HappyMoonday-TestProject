//
//  AddBookInfoViewModel.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/10/25.
//

import Foundation
import Combine

enum SelectedCategory: String {
    case reading = "읽고 있는 도서"
    case wantToRead = "읽고 싶은 도서"
    case readDone = "읽었던 도서"
    
    var bookCategory: BookCategory {
        switch self {
        case .reading: return .reading
        case .readDone: return .readDone
        case .wantToRead: return .wantToRead
        }
    }
}

final class AddBookInfoViewModel: BaseViewModel {
    private let usecase: LibraryUsecaseProtocol
    private(set) var selectedCategory: SelectedCategory?
    private var savingBookInfo: Book.Entity.BookItem = .init()
    
    init(usecase: LibraryUsecaseProtocol) {
        self.usecase = usecase
        super.init(usecase: usecase)
    }
    
    func saveBookInfo(title: String, author: String, description: String) throws {
        guard let selectedCategory = selectedCategory else { return }
        savingBookInfo = .init(title: title,
                             link: "",
                             image: "",
                             author: author,
                             discount: "",
                             publisher: "",
                             pubdate: "",
                             isbn: "",
                             description: description)
        do {
            try usecase.changeBookCategory(savingBookInfo, to: selectedCategory.bookCategory)
        } catch { throw error }
    }
    
    func updateCategory(with text: String) {
        selectedCategory = .init(rawValue: text)
    }
}
