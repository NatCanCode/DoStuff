//
//  TaskFilter.swift
//  ToDoList
//
//  Created by N N on 05/01/2023.
//

import Foundation
import SwiftUI

enum TaskFilter: String, CaseIterable {
    case all = "All"
    case nonCompleted = "To Do"
    case completed = "Completed"
    case overDue = "Overdue"
}
