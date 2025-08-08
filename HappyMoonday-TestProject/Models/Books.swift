//
//  Books.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

enum Book {
    enum Search {
        struct Request {
            let query: String // 검색어. UTF-8로 인코딩되어야 합니다.
            let display: Int? // 한 번에 표시할 검색 결과 개수(기본값: 10, 최댓값: 100)
            let start: Int? // 검색 시작 위치(기본값: 1, 최댓값: 1000)
            let sort: String? // 검색 결과 정렬 방법
//            - sim: 정확도순으로 내림차순 정렬(기본값)
//            - date: 출간일순으로 내림차순 정렬
        }
        
        struct Entity {
            
        }
        
        struct Response {
            
        }
    }
    
    enum Detail {
        
    }
}
