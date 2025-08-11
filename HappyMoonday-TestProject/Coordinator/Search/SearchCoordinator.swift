//
//  SearchCoordinator.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/8/25.
//

import UIKit

final class SearchCoordinator: NSObject, SearchCoordinatable {
    
    var parentCoordinator: AnyCoordinator?
    var currentFlowManager: CurrentFlowManager?
    
    var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        let viewModel: SearchBooksMainViewModel = SearchBooksMainViewModel(usecase: Injector.shared.resolve(SearchBooksUsecaseProtocol.self)!)
        let searchVC = SearchBooksMainViewController(viewModel: viewModel)
        searchVC.coordinator = self
        rootViewController = UINavigationController(rootViewController: searchVC)
        return rootViewController
    }
    
    func moveTo(_ appFlow: SearchScene, userData: [String : Any]?) {
        DispatchMain.async {
            switch appFlow {
            case .main:
                self.rootNavigationController?.popToRootViewController(animated: true)
            }
        }
    }
}
