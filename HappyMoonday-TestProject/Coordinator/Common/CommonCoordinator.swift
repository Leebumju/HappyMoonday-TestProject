//
//  CommonCoordinator.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

import UIKit

final class CommonCoordinator: CommonCoordinatable {
    var currentFlowManager: CurrentFlowManager?
    var parentCoordinator: AnyCoordinator?
    var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        return UIViewController()
    }
    
    func moveTo(_ appFlow: CommonScene, userData: [String: Any]?) {
        DispatchMain.async {
            switch appFlow {
            case .bookDetail:
                self.moveToBookDetailScene(userData)
            }
        }
    }
    
    private func moveToBookDetailScene(_ userData: [String: Any]?) {
        let viewModel: BookDetailViewModel = BookDetailViewModel(usecase: Injector.shared.resolve(SearchBooksUsecaseProtocol.self)!)
        let bookDetailVC = BookDetailViewController(viewModel: viewModel)
        bookDetailVC.coordinator = self
        currentNavigationViewController?.pushViewController(bookDetailVC, animated: true)
    }
}
