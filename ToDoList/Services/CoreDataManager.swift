//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by N N on 04/03/2023.
//

import SwiftUI
import CoreData

class CoreDataManager {

    static var shared = CoreDataManager()

    var container = PersistenceController.shared.container

    func fetch<R: NSFetchRequestResult>(_ entityName: String, sorting: [NSSortDescriptor]?) -> [R] {
        let request = NSFetchRequest<R>(entityName: entityName)
        request.sortDescriptors = sorting
        do {
            return try container.viewContext.fetch(request)
        } catch let error {
            print("(error)")
        }
        return []
    }

    func delete(object: NSManagedObject) {
        withAnimation {
            container.viewContext.delete(object)
            saveData()
        }
    }

    func delete(objects: [NSManagedObject]) {
        withAnimation {
            objects.forEach { container.viewContext.delete($0) }
            saveData()
        }
    }

    func saveData() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving (error)")
        }
    }

    func scheduleNotification(of task: TaskItem) {
        guard let id = task.id else { return }
        guard let notificationDate = task.dueDate else { return }

        let content = UNMutableNotificationContent()

        content.title = "Check your Do Stuff App"
        content.subtitle = "You might have something to do 🤭"
        content.body = "\(task.name!), due for: \(task.dueDate!.medium)"
        content.sound = .default
//        content.badge = 1

        let dateTrigger = UNCalendarNotificationTrigger(dateMatching: notificationDate.components, repeats: false)

        let request = UNNotificationRequest(identifier: id.uuidString, content: content, trigger: dateTrigger)

        UNUserNotificationCenter.current().add(request)
    }
}
