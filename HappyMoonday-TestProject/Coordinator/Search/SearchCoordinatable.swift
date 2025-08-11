//
//  SearchCoordinatable.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/8/25.
//

import Foundation

typealias AnySearchCoordinator = (any SearchCoordinatable)

protocol SearchCoordinatable: Coordinatable, CurrentCoordinated where FlowType == SearchScene {}

protocol SearchCoordinated: AnyObject {
    var coordinator: AnySearchCoordinator? { get }
}
