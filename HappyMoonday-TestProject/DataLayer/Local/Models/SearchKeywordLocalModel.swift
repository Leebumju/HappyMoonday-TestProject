//
//  SearchKeywordLocalModel.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

import RealmSwift
import Foundation

final class RealmSearchKeywordItem: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var keyword: String
    @Persisted var searchedAt: Date = Date()
}
