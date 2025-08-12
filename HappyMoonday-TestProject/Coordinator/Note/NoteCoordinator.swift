//
//  NoteCoordinator.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/8/25.
//

import UIKit
import SwiftUI

final class NoteCoordinator: NSObject, NoteCoordinatable {
    
    var parentCoordinator: AnyCoordinator?
    var currentFlowManager: CurrentFlowManager?
    
    var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        let viewModel = NoteMainViewModel(usecase: Injector.shared.resolve(NoteUsecaseProtocol.self)!)
         let rootView = NoteMainView(viewModel: viewModel, coordinator: self)
         let noteMainVC = UIHostingController(rootView: rootView)
         
         rootViewController = UINavigationController(rootViewController: noteMainVC)
         return rootViewController
    }
    
    func moveTo(_ appFlow: NoteScene, userData: [String : Any]?) {
        DispatchMain.async {
            switch appFlow {
            case .main:
                self.rootNavigationController?.popToRootViewController(animated: true)
            case .noteBook:
                self.moveToNoteBookScene(userData: userData)
            }
        }
    }
    
    func moveToNoteBookScene(userData: [String : Any]?) {
        guard let bookInfo = userData?["bookInfo"] as? Book.Entity.BookItem else { return }
        let viewModel: NoteBookViewModel = NoteBookViewModel(usecase: Injector.shared.resolve(NoteUsecaseProtocol.self)!,
                                                             bookInfo: bookInfo)
        let noteBookVC = UIHostingController(rootView: NoteBookView(viewModel: viewModel,
                                                                    coordinator: self))
        noteBookVC.hidesBottomBarWhenPushed = true
        currentNavigationViewController?.pushViewController(noteBookVC, animated: true)
    }
}
