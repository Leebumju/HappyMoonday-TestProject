//
//  Books.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

enum BookCategory: String {
    case reading
    case wantToRead
    case readDone
}

enum Book {
    struct Request {
        var query: String // 검색어. UTF-8로 인코딩되어야 합니다.
        var display: Int? // 한 번에 표시할 검색 결과 개수(기본값: 10, 최댓값: 100)
        var start: Int? // 검색 시작 위치(기본값: 1, 최댓값: 1000)
        var sort: String? // 검색 결과 정렬 방법  - sim: 정확도순으로 내림차순 정렬(기본값)  - date: 출간일순으로 내림차순 정렬
    }
    
    struct Entity {
        let lastBuildDate: String
        let total: Int
        let start: Int
        let display: Int
        let items: [BookItem]
        
        init(lastBuildDate: String, total: Int, start: Int, display: Int, items: [BookItem]) {
            self.lastBuildDate = lastBuildDate
            self.total = total
            self.start = start
            self.display = display
            self.items = items
        }
        
        init() {
            self.lastBuildDate = ""
            self.total = 0
            self.start = 0
            self.display = 0
            self.items = []
        }
        
        struct BookItem {
            let title: String
            let link: String
            let image: String
            let author: String
            let discount: String
            let publisher: String
            let pubdate: String
            let isbn: String
            let description: String
            
            init(title: String, link: String, image: String, author: String, discount: String, publisher: String, pubdate: String, isbn: String, description: String) {
                self.title = title
                self.link = link
                self.image = image
                self.author = author
                self.discount = discount
                self.publisher = publisher
                self.pubdate = pubdate
                self.isbn = isbn
                self.description = description
            }
            
            init() {
                self.title = ""
                self.link = ""
                self.image = ""
                self.author = ""
                self.discount = ""
                self.publisher = ""
                self.pubdate = ""
                self.isbn = ""
                self.description = ""
            }
        }
    }
    
    struct Response: Decodable {
        let lastBuildDate: String?
        let total: Int?
        let start: Int?
        let display: Int?
        let items: [BookItem]?
        
        struct BookItem: Decodable {
            let title: String?
            let link: String?
            let image: String?
            let author: String?
            let discount: String?
            let publisher: String?
            let pubdate: String?
            let isbn: String?
            let description: String?
        }
        
        var entity: Entity {
            return Entity(
                lastBuildDate: lastBuildDate ?? "",
                total: total ?? 0,
                start: start ?? 0,
                display: display ?? 0,
                items: items?.map { item in
                    Entity.BookItem(
                        title: item.title ?? "",
                        link: item.link ?? "",
                        image: item.image ?? "",
                        author: item.author ?? "",
                        discount: item.discount ?? "",
                        publisher: item.publisher ?? "",
                        pubdate: item.pubdate ?? "",
                        isbn: item.isbn ?? "",
                        description: item.description ?? ""
                    )
                } ?? []
            )
        }
    }
}

extension Book.Entity.BookItem: Identifiable {
    var id: String { isbn }
}
