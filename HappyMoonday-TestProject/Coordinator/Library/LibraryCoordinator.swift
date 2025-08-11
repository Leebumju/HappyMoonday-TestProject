//
//  LibraryCoordinator.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/8/25.
//

import UIKit

final class LibraryCoordinator: NSObject, LibraryCoordinatable {
    
    var parentCoordinator: AnyCoordinator?
    var currentFlowManager: CurrentFlowManager?
    
    var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        let viewModel: LibraryMainViewModel = LibraryMainViewModel(usecase: Injector.shared.resolve(LibraryUsecaseProtocol.self)!)
        let libraryVC = LibraryMainViewController(viewModel: viewModel)
        libraryVC.coordinator = self
        rootViewController = UINavigationController(rootViewController: libraryVC)
        
        return rootViewController
    }
    
    func moveTo(_ appFlow: LibraryScene, userData: [String : Any]?) {
        DispatchMain.async {
            switch appFlow {
            case .main:
                self.rootNavigationController?.popToRootViewController(animated: true)
            case .addBookInfo:
                self.moveToAddBookInfoScene(userData)
            }
        }
    }
    
    private func moveToAddBookInfoScene(_ userData: [String: Any]?) {
        let viewModel: AddBookInfoViewModel = AddBookInfoViewModel(usecase: Injector.shared.resolve(LibraryUsecaseProtocol.self)!)
        let addBookInfoVC = AddBookInfoViewController(viewModel: viewModel)
        addBookInfoVC.coordinator = self
        currentNavigationViewController?.pushViewController(addBookInfoVC, animated: true)
    }
}
