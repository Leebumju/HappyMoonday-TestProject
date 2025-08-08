//
//  TabBarCoordinator.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/8/25.
//

import UIKit

final class TabBarCoordinator: NSObject, TabBarCoordinatable {
    var parentCoordinator: AnyCoordinator?
    var currentFlowManager: CurrentFlowManager?
    var rootViewController: UIViewController = UITabBarController()
    
    var libraryCoordinator: AnyLibraryCoordinator = LibraryCoordinator()
    var searchCoordinator: AnySearchCoordinator = SearchCoordinator()
    var noteCoordinator: AnyNoteCoordinator = NoteCoordinator()
    
    func start() -> UIViewController {
        let libraryVC = configureTabBarVCs(of: .library)
        let searchVC = configureTabBarVCs(of: .search)
        let noteVC = configureTabBarVCs(of: .note)
        
        let rootTabBar = rootViewController as? UITabBarController
        
        rootTabBar?.delegate = self
        rootTabBar?.viewControllers = [libraryVC, searchVC, noteVC]
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundImage = UIImage()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        
        UITabBar.appearance().standardAppearance = appearance
        rootTabBar?.tabBar.standardAppearance = appearance
        
        if #available(iOS 15.0, *) {
            rootTabBar?.tabBar.scrollEdgeAppearance = appearance
        }
        
        currentFlowManager = CurrentFlowManager()
        currentFlowManager?.currentCoordinator = libraryCoordinator
        
        libraryCoordinator.currentFlowManager = currentFlowManager
        searchCoordinator.currentFlowManager = currentFlowManager
        noteCoordinator.currentFlowManager = currentFlowManager
        
        return rootViewController
    }
    
    func moveTo(_ appFlow: TabBarFlow, userData: [String : Any]?) {
        switch appFlow {
        case .library(let libraryScene):
            startLibraryFlow(libraryScene, userData: userData)
        case .search(let searchScene):
            startSearchFlow(searchScene, userData: userData)
        case .note(let noteScene):
            startNoteFlow(noteScene, userData: userData)
        }
    }
    
    private func startLibraryFlow(_ flow: Flow, userData: [String: Any]?) {
        currentFlowManager?.currentCoordinator = libraryCoordinator
        (rootViewController as? UITabBarController)?.selectedIndex = TabType.library.rawValue
        libraryCoordinator.moveToAnotherFlow(flow, userData: userData)
    }
    
    private func startSearchFlow(_ flow: Flow, userData: [String: Any]?) {
        currentFlowManager?.currentCoordinator = searchCoordinator
        (rootViewController as? UITabBarController)?.selectedIndex = TabType.search.rawValue
        searchCoordinator.moveToAnotherFlow(flow, userData: userData)
    }
    
    private func startNoteFlow(_ flow: Flow, userData: [String: Any]?) {
        currentFlowManager?.currentCoordinator = noteCoordinator
        (rootViewController as? UITabBarController)?.selectedIndex = TabType.note.rawValue
        noteCoordinator.moveToAnotherFlow(flow, userData: userData)
    }
    
    private func configureTabBarVCs(of tabType: TabType) -> UIViewController {
        let vc: UIViewController
        switch tabType {
        case .library:
            vc = libraryCoordinator.start()
            libraryCoordinator.parentCoordinator = self
            vc.tabBarItem = UITabBarItem(title: nil,
                                         image: UIImage(systemName: "circle.fill")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal),
                                         selectedImage: UIImage(systemName: "circle.fill")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal))
        case .search:
            vc = searchCoordinator.start()
            searchCoordinator.parentCoordinator = self
            vc.tabBarItem = UITabBarItem(title: nil,
                                         image: UIImage(systemName: "circle.fill")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal),
                                         selectedImage: UIImage(systemName: "circle.fill")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal))
        case .note:
            vc = noteCoordinator.start()
            noteCoordinator.parentCoordinator = self
            vc.tabBarItem = UITabBarItem(title: nil,
                                         image: UIImage(systemName: "circle.fill")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal),
                                         selectedImage: UIImage(systemName: "circle.fill")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal))
        }
        
        vc.tabBarItem.imageInsets = UIEdgeInsets(top: 14, left: 0, bottom: -29, right: 0)
        return vc
    }
}

// MARK: - UITabBarControllerDelegate
extension TabBarCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let tabType = TabType(rawValue: tabBarController.selectedIndex) else { return }
        
        switch tabType {
        case .library:
            currentFlowManager?.currentCoordinator = libraryCoordinator
        case .search:
            currentFlowManager?.currentCoordinator = searchCoordinator
        case .note:
            currentFlowManager?.currentCoordinator = noteCoordinator
        }
    }
    
}

extension TabBarCoordinator {
    private enum TabType: Int {
        case library
        case search
        case note
        
        init?(rawValue: Int) {
            switch rawValue {
            case TabType.library.rawValue:
                self = .library
            case TabType.search.rawValue:
                self = .search
            case TabType.note.rawValue:
                self = .note
            default:
                return nil
            }
        }
    }
}
