//
//  LocalDataFetcher.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

import Foundation
import Combine
import RealmSwift

final class LocalDataFetcher: LocalDataFetchable {
    func saveRecentSearchKeyword(_ keyword: String) throws {
        let realm = try Realm()  // 호출된 스레드에서 새 인스턴스 생성

        let obj = RecentSearchKeyword()
        obj.keyword = keyword
        obj.searchedAt = Date()

        try realm.write {
            realm.add(obj, update: .modified)
        }

        let allKeywords = realm.objects(RecentSearchKeyword.self)
            .sorted(byKeyPath: "searchedAt", ascending: false)
        if allKeywords.count > 5 {
            let toDelete = allKeywords.suffix(from: 5)
            try realm.write {
                realm.delete(toDelete)
            }
        }
    }

    func fetchRecentSearchKeywords() -> [String] {
        let realm = try! Realm() // 이 메서드가 호출된 스레드에서 Realm 인스턴스 생성
        let results = realm.objects(RecentSearchKeyword.self)
            .sorted(byKeyPath: "searchedAt", ascending: false)
            .prefix(5)
        return results.map { $0.keyword }
    }
}
// 저장
//    func saveBooks(_ books: [Book.Entity]) throws {
//        let objects = books.map { BookLocalModel(entity: $0) }
//        try realm.write {
//            realm.add(objects, update: .modified) // PK 기반 업데이트
//        }
//    }
//
//    // 조회
//    func fetchBooks() -> [Book.Entity] {
//        return realm.objects(BookLocalModel.self)
//            .map { $0.toEntity() }
//    }

// 삭제
//    func deleteBook(id: ObjectId) throws {
//        guard let object = realm.object(ofType: BookLocalModel.self, forPrimaryKey: id) else { return }
//        try realm.write {
//            realm.delete(object)
//        }
//    }
