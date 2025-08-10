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
        // TODO: - UIKit 변경시 주석 제거
//        let noteVC = NoteMainViewController()
////        noteVC.coordinator = self
//        rootViewController = UINavigationController(rootViewController: noteVC)
//        return rootViewController
        let noteVC = UIHostingController(rootView: NoteMainView())
        rootViewController = UINavigationController(rootViewController: noteVC)
        
        return rootViewController
    }
    
    func moveTo(_ appFlow: NoteScene, userData: [String : Any]?) {
        DispatchMain.async {
            switch appFlow {
            case .main:
                self.rootNavigationController?.popToRootViewController(animated: true)
            }
        }
    }
}
