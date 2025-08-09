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

    init(usecase: SearchBooksUsecaseProtocol) {
        self.usecase = usecase
        super.init(usecase: usecase)
    }
}
