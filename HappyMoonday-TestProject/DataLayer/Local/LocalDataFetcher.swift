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
    func changeBookCategory(_ bookEntity: Book.Entity.BookItem, to categoryName: BookCategory) throws {
        let realm = try Realm()
        
        var updatedEntity = bookEntity
        if updatedEntity.isbn.isEmpty {
            let newISBN = generateUserISBN(in: realm)
            print(">>>> generated ISBN: \(newISBN)")
            
            updatedEntity = Book.Entity.BookItem(
                title: updatedEntity.title,
                link: updatedEntity.link,
                image: updatedEntity.image,
                author: updatedEntity.author,
                discount: updatedEntity.discount,
                publisher: updatedEntity.publisher,
                pubdate: updatedEntity.pubdate,
                isbn: newISBN,
                description: updatedEntity.description
            )
        }
        
        try realm.write {
            let category = realm.objects(BookCategoryEntity.self)
                .filter("name == %@", categoryName.rawValue)
                .first ?? {
                    let newCategory = BookCategoryEntity()
                    newCategory.id = ObjectId.generate()
                    newCategory.name = categoryName.rawValue
                    realm.add(newCategory)
                    return newCategory
                }()
            
            let realmBook: RealmBookItem
            if let existingBook = realm.object(ofType: RealmBookItem.self, forPrimaryKey: updatedEntity.isbn) {
                realmBook = existingBook
            } else {
                realmBook = RealmBookItem(from: updatedEntity)
                realm.add(realmBook)
            }
            
            if !category.books.contains(realmBook) {
                category.books.append(realmBook)
            }
        }
    }
    
    func fetchBooks(in categoryName: BookCategory) -> [Book.Entity.BookItem] {
        let realm = try! Realm()
        guard let category = realm.objects(BookCategoryEntity.self)
            .filter("name == %@", categoryName.rawValue)
            .first else {
            return []
        }
        
        return category.books.map { realmBook in
            Book.Entity.BookItem(
                title: realmBook.title,
                link: realmBook.link,
                image: realmBook.image,
                author: realmBook.author,
                discount: realmBook.discount,
                publisher: realmBook.publisher,
                pubdate: realmBook.pubdate,
                isbn: realmBook.isbn,
                description: realmBook.bookDescription
            )
        }
    }
    
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
    
    private func generateUserISBN(in realm: Realm) -> String {
        let userBooksCount = realm.objects(RealmBookItem.self)
            .filter("isbn BEGINSWITH %@", "user")
            .count
        return "user\(userBooksCount)"
    }
}

final class RealmBookItem: Object {
    @Persisted(primaryKey: true) var isbn: String = ""
    @Persisted var title: String = ""
    @Persisted var link: String = ""
    @Persisted var image: String = ""
    @Persisted var author: String = ""
    @Persisted var discount: String = ""
    @Persisted var publisher: String = ""
    @Persisted var pubdate: String = ""
    @Persisted var bookDescription: String = ""
    
    convenience init(from entity: Book.Entity.BookItem) {
        self.init()
        self.isbn = entity.isbn
        self.title = entity.title
        self.link = entity.link
        self.image = entity.image
        self.author = entity.author
        self.discount = entity.discount
        self.publisher = entity.publisher
        self.pubdate = entity.pubdate
        self.bookDescription = entity.description
    }
}

final class BookCategoryEntity: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String = ""
    @Persisted var books = List<RealmBookItem>()
}
