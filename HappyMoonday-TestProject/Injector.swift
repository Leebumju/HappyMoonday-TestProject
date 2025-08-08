//
//  Injector.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/8/25.
//

import Foundation
import Swinject

struct Injector {
    private init() {}
    
    static let shared: Container = {
        let container = Container()
        
        // MARK: - DataFetchable
        container.register(RemoteDataFetchable.self) { _ in
            return RemoteDataFetcher()
        }
        
        return container
    }()
}
