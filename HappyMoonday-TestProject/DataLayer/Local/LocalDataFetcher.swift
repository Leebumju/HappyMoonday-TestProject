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
        let realm = try Realm()
        
        try realm.write {
            if let existing = realm.objects(RecentSearchKeyword.self)
                .filter("keyword == %@", keyword)
                .first {
                existing.searchedAt = Date()
            } else {
                let obj = RecentSearchKeyword()
                obj.keyword = keyword
                obj.searchedAt = Date()
                realm.add(obj)
            }
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
        let realm = try! Realm()
        return realm.objects(RecentSearchKeyword.self)
            .sorted(byKeyPath: "searchedAt", ascending: false)
            .prefix(5)
            .map { $0.keyword }
    }
}
