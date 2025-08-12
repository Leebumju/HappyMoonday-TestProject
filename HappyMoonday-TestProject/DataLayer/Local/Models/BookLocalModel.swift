//
//  LocalModel.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

import RealmSwift
import Foundation

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
    @Persisted var recordDate: Date?
    @Persisted var startDate: Date?
    @Persisted var endDate: Date?
    @Persisted var note: String?
    
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
        self.recordDate = entity.recordDate
        self.startDate = entity.startDate
        self.endDate = entity.endDate
        self.note = entity.note
    }
}

final class BookCategoryEntity: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String = ""
    @Persisted var books = List<RealmBookItem>()
}
