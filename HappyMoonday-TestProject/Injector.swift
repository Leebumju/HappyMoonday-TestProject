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
        
        container.register(LocalDataFetchable.self) { _ in
            return LocalDataFetcher()
        }
        
        container.register(LibraryRepositoryProtocol.self) { resolver in
            let repository = LibraryRepository(remoteDataFetcher: resolver.resolve(RemoteDataFetchable.self)!,
                                              localDataFetcher: resolver.resolve(LocalDataFetchable.self)!)
            return repository
        }
        
        container.register(LibraryUsecaseProtocol.self) { resolver in
            let usecase = LibraryUsecase(repository: resolver.resolve(LibraryRepositoryProtocol.self)!)
            return usecase
        }
        
        return container
    }()
}
