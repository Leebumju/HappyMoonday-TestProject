//
//  AppCoordinator.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/8/25.
//

import UIKit

final class AppCoordinator: AppCoordinatable {
    var tabBarCoordinator: AnyTabBarCoordinator = TabBarCoordinator()
    var mainTabBar: UITabBarController?
    var parentCoordinator: AnyCoordinator?
    var shouldResetTabBar: Bool = false
    var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        let splashVC: SplashViewController = SplashViewController()
        splashVC.coordinator = self
        
        rootViewController = UINavigationController(rootViewController: splashVC)
        rootViewController.hidesBottomBarWhenPushed = true
        
        let navigation: UINavigationController? = rootViewController as? UINavigationController
        navigation?.isNavigationBarHidden = true
        return rootViewController
    }
    
    func moveTo(_ appFlow: AppFlow, userData: [String: Any]?) {
        guard let flow = appFlow.appFlow else { return }
        
        if mainTabBar == nil {
            tabBarCoordinator.parentCoordinator = self
            self.mainTabBar = tabBarCoordinator.start() as? UITabBarController
        }
        
        switch flow {
        case .tabBar(let tabBarFlow):
            startTabBarFlow(tabBarFlow, userData: userData)
        }
    }
    
    private func startTabBarFlow(_ tabBarFlow: TabBarFlow, userData: [String: Any]?) {
        guard let mainTabBar = self.mainTabBar else { return }
        
        if !(rootNavigationController?.viewControllers.first is UITabBarController) {
            rootNavigationController?.viewControllers.removeAll()
            rootNavigationController?.pushViewController(mainTabBar, animated: false)
        }
        
        tabBarCoordinator.currentNavigationViewController?.popToRootViewController(animated: false)
        tabBarCoordinator.moveTo(tabBarFlow, userData: userData)
    }
    
    @discardableResult
    private func removeSubViewController() -> Bool {
        guard let rootNavigationController = rootNavigationController else { return false }
        
        rootNavigationController.viewControllers
            .forEach { viewController in
                viewController.removeFromParent()
            }
        
        return true
    }
}
