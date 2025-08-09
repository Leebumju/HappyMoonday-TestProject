//
//  SearchBooksUsecaseProtocol.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

protocol SearchBooksUsecaseProtocol: BaseUsecaseProtocol {
    func searchBooks(with requestModel: Book.Request) async throws -> Book.Entity
}
