//
//  DecodeUtil.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

import Foundation

struct DecodeUtil {
    static private let decoder = JSONDecoder()
    
    static func decode<T: Decodable>(_ type: T.Type, data: Data) throws -> T? {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(type, from: data)
    }
}
