//
//  RemoteDataFetcher.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/8/25.
//

import Foundation
import Moya

final class RemoteDataFetcher: RemoteDataFetchable {
    private let networkWrapper: NetworkWrapper = NetworkWrapper.shared
    
    func searchBooks() async throws {
        do {
            let params: [String: Any] = ["query": "해리포터"]
  
            let response = try await networkWrapper.fetchPublicService(.searchBooks(params: params))
            
            if let responseString = String(data: response.data, encoding: .utf8) {
                print(responseString)
            } else {
                print("응답 데이터를 문자열로 변환할 수 없습니다.")
            }
            
//            guard let decodedResponse = try DecodeUtil.decode(Book.Search.self, data: response.data) else {
//                throw NetworkError.typeMismatch
//            }
            
//            return decodedResponse.entity
        } catch {
            print(error)
            throw error
        }
    }
}

enum NetworkError: LocalizedError {
    case typeMismatch
    case unknownError
    case emptyToken
    case emptyData
}
