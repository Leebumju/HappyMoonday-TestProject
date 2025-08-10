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
            case .web:
                self.moveToWebScene(userData)
            case .bookDetail:
                self.moveToBookDetailScene(userData)
            }
        }
    }
    
    private func moveToWebScene(_ userData: [String: Any]?) {
        guard let urlRequest = userData?["urlRequest"] as? URLRequest else { return }
        let webVC: BaseWebViewController = BaseWebViewController(urlRequest: urlRequest)
        currentNavigationViewController?.pushViewController(webVC, animated: true)
    }
    
    private func moveToBookDetailScene(_ userData: [String: Any]?) {
        guard let bookInfo = userData?["bookInfo"] as? Book.Entity.BookItem else { return }
        let viewModel: BookDetailViewModel = BookDetailViewModel(usecase: Injector.shared.resolve(SearchBooksUsecaseProtocol.self)!,
                                                                 bookInfo: bookInfo)
        
        let bookDetailVC = BookDetailViewController(viewModel: viewModel)
        bookDetailVC.coordinator = self
        currentNavigationViewController?.pushViewController(bookDetailVC, animated: true)
    }
}
