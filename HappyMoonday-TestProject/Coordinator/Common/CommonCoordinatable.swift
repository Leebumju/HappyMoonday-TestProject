//
//  CommonCoordinatable.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/9/25.
//

import Foundation

typealias AnyCommonCoordinator = (any CommonCoordinatable)

protocol CommonCoordinatable: Coordinatable, CurrentCoordinated where FlowType == CommonScene {}

protocol CommonCoordinated: AnyObject {
    var coordinator: AnyCommonCoordinator? { get }
}
