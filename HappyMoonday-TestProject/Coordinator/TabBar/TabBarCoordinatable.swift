//
//  TabBarCoordinatable.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/8/25.
//

import Foundation

typealias AnyTabBarCoordinator = (any TabBarCoordinatable)

protocol TabBarCoordinatable: Coordinatable, CurrentCoordinated where FlowType == TabBarFlow {
    
    var libraryCoordinator: AnyLibraryCoordinator { get }
    var searchCoordinator: AnySearchCoordinator { get }
    var noteCoordinator: AnyNoteCoordinator { get }
}

protocol TabBarCoordinated: AnyObject {
    var coordinator: AnyTabBarCoordinator? { get }
}
