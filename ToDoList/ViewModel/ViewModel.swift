//
//  viewModel.swift
//  ToDoList
//
//  Created by N N on 05/01/2023.
//

import Foundation
import SwiftUI
import CoreData
import UserNotifications

final class ViewModel: ObservableObject {

    init() {
        fetchTasks()
    }

    enum TaskState: String {
        case saving = "Save"
        case updating = "Update"
    }

    @Published var taskItems: [TaskItem] = []
    @Published var date = Date()
    @Published var selectedFilter = TaskFilter.all
    @Published var taskState: TaskState = .saving
    @Published var selectedTask: TaskItem?
    
    func moveDate(_ days: Int) {
        let calendar: Calendar = Calendar.current
        date = calendar.date(byAdding: .day, value: days, to: date)!
        fetchTasks()
    }

    func isOnScrollerDate(task: TaskItem) -> Bool {
        task.dueDate?.components.day == date.components.day &&
        task.dueDate?.components.month == date.components.month &&
        task.dueDate?.components.year == date.components.year
    }

    func fetchTasks() {
        let sortDescriptors = sortOrder()
        taskItems = CoreDataManager.shared.fetch("TaskItem", sorting: sortDescriptors)
    }
    
    private func sortOrder() -> [NSSortDescriptor] {
        let completedDateSort = NSSortDescriptor(keyPath: \TaskItem.completedDate, ascending: true)
        let timeSort = NSSortDescriptor(keyPath: \TaskItem.scheduleTime, ascending: true)
        let dueDateSort = NSSortDescriptor(keyPath: \TaskItem.dueDate, ascending: true)
        return [completedDateSort, timeSort, dueDateSort]
    }

    func saveTask(id: UUID, createdDate: Date, name: String, dueDate: Date, scheduleTime: Bool, selectedCategory: Category) {
        withAnimation {
            // Item initialized in Save func:
            let selectedTaskItem = TaskItem(context: CoreDataManager.shared.container.viewContext)

            selectedTaskItem.id = UUID()
            selectedTaskItem.createdDate = Date()
            selectedTaskItem.name = name
            selectedTaskItem.dueDate = dueDate
            selectedTaskItem.scheduleTime = scheduleTime
            selectedTaskItem.selectedCategory = selectedCategory

            CoreDataManager.shared.saveData()
            fetchTasks()

            scheduleNotification(task: selectedTaskItem)
        }
    }

    func scheduleNotification(task: TaskItem) {
        // Configure notification content:
        let content = UNMutableNotificationContent()
        content.title = "Check your to do list"
        content.subtitle = "You might have something to do 🤭"
        content.body = "\(task.name!), due for: \(task.dueDate!.medium)"
        content.sound = UNNotificationSound.default
//        content.badge = 1

        // Create the trigger as a repeating event:
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: NotificationHelper.getTriggerDate(triggerDate: task.dueDate ?? Calendar.current.date(byAdding: .day, value: -1, to: .now)!)!,
                    repeats: false
                )

        let notification = NotificationManager().scheduleNotification(id: "\(String(describing: task.id))", content: content, trigger: trigger)
        print(notification)
    }

    func updateTask(id: UUID, createdDate: Date, name: String, dueDate: Date, scheduleTime: Bool, selectedCategory: Category) {
        if let index = taskItems.firstIndex(where: {
            $0.id == id
        }) {
            taskItems[index].id = id
            taskItems[index].createdDate = createdDate
            taskItems[index].name = name
            taskItems[index].dueDate = dueDate
            taskItems[index].scheduleTime = scheduleTime
            taskItems[index].selectedCategory = selectedCategory

            CoreDataManager.shared.saveData()
            fetchTasks()

            NotificationManager().removePendingNotification(id: "\(String(describing: taskItems[index].id))")
            scheduleNotification(task: taskItems[index])
        }
    }

    func filteredTaskItems() -> [TaskItem] {
        switch selectedFilter {
        case .all:
            return taskItems.filter { isOnScrollerDate(task: $0) }
        case .nonCompleted:
            return taskItems.filter { !$0.isDone }.filter { isOnScrollerDate(task: $0) }
        case .completed:
            return taskItems.filter { $0.isDone }.filter { isOnScrollerDate(task: $0) }
        case .overDue:
            return taskItems.filter { $0.isOverdue() }.filter { isOnScrollerDate(task: $0) }
        }
    }

    func toggleTaskValidation(task: TaskItem) {
        if let index = taskItems.firstIndex(where: {
            $0.id == task.id
        }) {
            taskItems[index].isDone.toggle()
            CoreDataManager.shared.saveData()
            fetchTasks()
        }
    }

    func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { taskItems[$0] }.forEach { task in
//                print("\(String(describing: task.id))")
            NotificationManager().removePendingNotification(id: "\(String(describing: task.id))")
            }
//            offsets.map { taskItems[$0] }.forEach(NotificationManager().removePendingNotification(id: "\(taskItems[index].id)"))

            offsets.map { taskItems[$0] }.forEach(CoreDataManager.shared.container.viewContext.delete)
            CoreDataManager.shared.saveData()
        }
    }

//    func scheduleNotification(task: TaskItem) {
//        // Configure notification content:
//        let content = UNMutableNotificationContent()
//        content.title = "Check your to do list"
//        content.subtitle = "You might have something to do 🤭"
//        content.body = "\(task.name!), due for: \(task.dueDate!.medium)"
//        content.sound = UNNotificationSound.default
//        content.badge = 1
//
//        // Configure recurring date:
//        let calendar = Calendar.current
//
//        // Notify 30 min before deadline:
//        // let justBeforeDueDate = calendar.date(byAdding: .hour, value: -1, to: task.dueDate ?? Date())
//        let justBeforeDueDate = calendar.date(byAdding: .minute, value: -30, to: task.dueDate ?? Date())
//        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: justBeforeDueDate ?? Date())
//
//        // Create the trigger as a repeating event:
//        let trigger = UNCalendarNotificationTrigger(
//            dateMatching: dateComponents, repeats: false)
//
//        // Create the request:
//        let uuidString = UUID().uuidString
//        let request = UNNotificationRequest(identifier: uuidString,
//                                            content: content, trigger: trigger)
//
//        // Schedule the request:
//        let notificationCenter = UNUserNotificationCenter.current()
//        notificationCenter.add(request) { (error) in
//            if error != nil {
//                // Handle any errors.
//            }
//        }

}
