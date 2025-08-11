//
//  LocalModel.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

import RealmSwift

class BookLocalModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String = ""
    @Persisted var link: String = ""
    @Persisted var image: String = ""
    @Persisted var author: String = ""
    @Persisted var discount: String = ""
    @Persisted var publisher: String = ""
    @Persisted var pubdate: String = ""
    @Persisted var isbn: String = ""
    @Persisted var bookDescription: String = ""

    convenience init(entity: Book.Entity.BookItem) {
        self.init()
        self.title = entity.title
        self.link = entity.link
        self.image = entity.image
        self.author = entity.author
        self.discount = entity.discount
        self.publisher = entity.publisher
        self.pubdate = entity.pubdate
        self.isbn = entity.isbn
        self.bookDescription = entity.description
    }

    func toEntity() -> Book.Entity.BookItem {
        return Book.Entity.BookItem(
            title: title,
            link: link,
            image: image,
            author: author,
            discount: discount,
            publisher: publisher,
            pubdate: pubdate,
            isbn: isbn,
            description: bookDescription
        )
    }
}
