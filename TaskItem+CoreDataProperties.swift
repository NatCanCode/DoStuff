//
//  TaskItem+CoreDataProperties.swift
//  ToDoList
//
//  Created by N N on 01/03/2023.
//
//

import Foundation
import CoreData


extension TaskItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskItem> {
        return NSFetchRequest<TaskItem>(entityName: "TaskItem")
    }

    @NSManaged public var completedDate: Date?
    @NSManaged public var createdDate: Date?
    @NSManaged public var dueDate: Date?
    @NSManaged public var name: String?
    @NSManaged public var scheduleTime: Bool
    @NSManaged public var selectedCategory: Category
    @NSManaged public var isDone: Bool
    @NSManaged public var id: UUID?

}

extension TaskItem : Identifiable {

}
