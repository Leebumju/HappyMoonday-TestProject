//
//  Coordinator.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/8/25.
//

import UIKit

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var rootViewController: UIViewController { get set }
    
    func start() -> UIViewController
    func moveTo(appFlow: Flow, userData: [String: Any]?)
}

extension Coordinator {
    var rootNavigationController: UINavigationController? {
        (rootViewController as? UINavigationController)
    }
}

protocol Coordinated {
    var coordinator: Coordinator? { get }
}

protocol Flow {}

extension Flow {
    var appFlow: AppFlow? {
        (self as? AppFlow)
    }
    
    var tabBarFlow: TabBarFlow? {
        (self as? TabBarFlow)
    }
}

enum AppFlow: Flow {
    case tabBar(TabBarFlow)
}

enum TabBarFlow: Flow {
    case library(LibraryScene)
    case search(SearchScene)
    case note(NoteScene)
    case common(CommonScene)
}

enum LibraryScene: Flow {
    case main
    case addBookInfo
}

enum SearchScene: Flow {
    case main
}

enum NoteScene: Flow {
    case main
    case noteBook
}

enum CommonScene: Flow {
    case web
    case bookDetail
    case singleTextBottomSheet
}
