//
//  TaskItemExtension.swift
//  ToDoList
//
//  Created by N N on 05/01/2023.
//

import SwiftUI

extension TaskItem {
    
    func isCompleted() -> Bool {
        return completedDate != nil 
    }
    
    func isOverdue() -> Bool {
        if let due = dueDate {
            return !isCompleted() && scheduleTime && due < Date()
        }
        return false
    }
    
    func overdueColor() -> Color {
        return isOverdue() ? Color("overdue") : .secondary
    }
    
    func dueDateTimeOnly() -> String {
        if let due = dueDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            return dateFormatter.string(from: due)
        }
        return ""
    }
}
