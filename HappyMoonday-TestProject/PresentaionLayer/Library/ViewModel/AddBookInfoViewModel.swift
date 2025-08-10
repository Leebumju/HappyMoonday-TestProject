//
//  AddBookInfoViewModel.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/10/25.
//

import Foundation
import Combine

final class AddBookInfoViewModel: BaseViewModel {
    private let usecase: LibraryUsecaseProtocol
    
    init(usecase: LibraryUsecaseProtocol) {
        self.usecase = usecase
        super.init(usecase: usecase)
    }
}
