//
//  NetworkService.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

import Foundation
import Moya

enum NetworkService {
    case searchBooks(params: [String: Any])
}

extension NetworkService: TargetType {
    var baseURL: URL {
        switch self {
        case .searchBooks:
            return URL(string: "https://openapi.naver.com")!
        }
    }
    
    var path: String {
        switch self {
        case .searchBooks:
            return "/v1/search/book.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .searchBooks: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .searchBooks(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["X-Naver-Client-Id": "0Gt0ErYrRKOvfOVhyoUF",
                "X-Naver-Client-Secret": "jGD41O2Bg5",
                "Accept": "*/*"]
    }
    
    var contentType: String {
        return "application/json"
    }
}

