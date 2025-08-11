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
    
    func searchBooks(with requestModel: Book.Request) async throws -> Book.Entity {
        do {
            var params: [String: Any] = ["query": requestModel.query]
            
            if let display = requestModel.display {
                params.updateValue(display, forKey: "display")
            }
            
            if let start = requestModel.start {
                params.updateValue(start, forKey: "start")
            }
            
            if let sort = requestModel.sort {
                params.updateValue(sort, forKey: "sort")
            }
  
            let response = try await networkWrapper.fetchPublicService(.searchBooks(params: params))
            
            guard let decodedResponse = try DecodeUtil.decode(Book.Response.self, data: response.data) else {
                throw NetworkError.typeMismatch
            }
            
            return decodedResponse.entity
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
