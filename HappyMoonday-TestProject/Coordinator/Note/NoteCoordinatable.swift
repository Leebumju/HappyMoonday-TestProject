//
//  NoteCoordinatable.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/8/25.
//

import Foundation

typealias AnyNoteCoordinator = (any NoteCoordinatable)

protocol NoteCoordinatable: Coordinatable, CurrentCoordinated where FlowType == NoteScene {}

protocol NoteCoordinated: AnyObject {
    var coordinator: AnyNoteCoordinator? { get }
}
