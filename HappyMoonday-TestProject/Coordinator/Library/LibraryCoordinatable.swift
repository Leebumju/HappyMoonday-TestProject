//
//  LibraryCoordinatable.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/8/25.
//

import Foundation

typealias AnyLibraryCoordinator = (any LibraryCoordinatable)

protocol LibraryCoordinatable: Coordinatable, CurrentCoordinated where FlowType == LibraryScene {}

protocol LibraryCoordinated: AnyObject {
    var coordinator: AnyLibraryCoordinator? { get }
}
