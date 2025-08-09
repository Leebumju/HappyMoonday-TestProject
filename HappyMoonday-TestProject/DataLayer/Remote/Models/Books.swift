//
//  Books.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

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
