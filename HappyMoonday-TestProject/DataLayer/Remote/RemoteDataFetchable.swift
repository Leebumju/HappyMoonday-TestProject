//
//  RemoteDataFetchable.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/8/25.
//

import Foundation

protocol RemoteDataFetchable: AnyObject {
    func searchBooks(with requestModel: Book.Request) async throws -> Book.Entity
}
