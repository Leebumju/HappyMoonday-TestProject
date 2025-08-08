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
    
    init(usecase: LibraryUsecaseProtocol) {
        self.usecase = usecase
        super.init(usecase: usecase)
    }
    
    func searchBooks() async throws {
        try await usecase.searchBooks()
    }
}
