//
//  AppCoordinatable.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/8/25.
//

import UIKit

typealias AnyAppCoordinator = (any AppCoordinatable)

protocol AppCoordinatable: Coordinatable where FlowType == AppFlow {
    var tabBarCoordinator: AnyTabBarCoordinator { get }
    var mainTabBar: UITabBarController? { get }
}

protocol AppCoordinated {
    var coordinator: AnyAppCoordinator? { get }
}
