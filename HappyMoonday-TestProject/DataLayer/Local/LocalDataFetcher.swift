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
            updatedEntity = Book.Entity.BookItem(
                title: updatedEntity.title,
                link: updatedEntity.link,
                image: updatedEntity.image,
                author: updatedEntity.author,
                discount: updatedEntity.discount,
                publisher: updatedEntity.publisher,
                pubdate: updatedEntity.pubdate,
                isbn: newISBN,
                description: updatedEntity.description,
                recordDate: updatedEntity.recordDate,
                startDate: updatedEntity.startDate,
                endDate: updatedEntity.endDate,
                note: updatedEntity.note
            )
        }
        
        try realm.write {
            let category = realm.objects(RealmBookCategoryList.self)
                .filter("name == %@", categoryName.rawValue)
                .first ?? {
                    let newCategory = RealmBookCategoryList()
                    newCategory.id = ObjectId.generate()
                    newCategory.name = categoryName.rawValue
                    realm.add(newCategory)
                    return newCategory
                }()
            
            var realmBook: RealmBookItem
            if let existingBook = realm.object(ofType: RealmBookItem.self, forPrimaryKey: updatedEntity.isbn) {
                realmBook = existingBook
                realmBook.title = updatedEntity.title
                realmBook.link = updatedEntity.link
                realmBook.image = updatedEntity.image
                realmBook.author = updatedEntity.author
                realmBook.discount = updatedEntity.discount
                realmBook.publisher = updatedEntity.publisher
                realmBook.pubdate = updatedEntity.pubdate
                realmBook.bookDescription = updatedEntity.description
                realmBook.recordDate = updatedEntity.recordDate
                realmBook.startDate = updatedEntity.startDate
                realmBook.endDate = updatedEntity.endDate
                realmBook.note = updatedEntity.note
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
        guard let category = realm.objects(RealmBookCategoryList.self)
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
                description: realmBook.bookDescription,
                recordDate: realmBook.recordDate,
                startDate: realmBook.startDate,
                endDate: realmBook.endDate,
                note: realmBook.note
            )
        }
    }
    
    func deleteBookInCategory(book: Book.Entity.BookItem, in category: BookCategory) throws {
        let realm = try! Realm()
         
         try realm.write {
             guard let categoryEntity = realm.objects(RealmBookCategoryList.self)
                     .filter("name == %@", category.rawValue)
                     .first else { return }
             
             guard let realmBook = realm.object(ofType: RealmBookItem.self, forPrimaryKey: book.isbn) else { return }
             
             if let index = categoryEntity.books.firstIndex(of: realmBook) {
                 categoryEntity.books.remove(at: index)
             }
         }
    }
    
    func saveRecentSearchKeyword(_ keyword: String) throws {
        let realm = try Realm()
        
        try realm.write {
            if let existing = realm.objects(RealmSearchKeywordItem.self)
                .filter("keyword == %@", keyword)
                .first {
                existing.searchedAt = Date()
            } else {
                let obj = RealmSearchKeywordItem()
                obj.keyword = keyword
                obj.searchedAt = Date()
                realm.add(obj)
            }
        }
        
        let allKeywords = realm.objects(RealmSearchKeywordItem.self)
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
        return realm.objects(RealmSearchKeywordItem.self)
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
