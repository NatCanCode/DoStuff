//
//  NotifcationsView.swift
//  ToDoList
//
//  Created by N N on 06/01/2023.
//

//import SwiftUI
//import UserNotifications
//
//// Local notifications can send any message at any time as long as the user allows it.
//struct NotifcationsView: View {
//    
//    @Environment(\.managedObjectContext) private var viewContext
//    @EnvironmentObject var dateHolder: DateHolder
//    @Environment(\.colorScheme) var colorScheme
//    @ObservedObject var passedTaskItem: TaskItem
//
//    var body: some View {
//        VStack {
//            Button("Request Permission") {
//                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//                    if success {
//                        print("All set!")
//                    } else if let error = error {
//                        print(error.localizedDescription)
//                    }
//                }
//            }
//        }
//    }
//    //            Button("Schedule Notification") {
//    func scheduleNotification(passedTaskItem: TaskItem) {
//        // Configure notification content:
//        let content = UNMutableNotificationContent()
//        content.title = "Check your to do list"
//        content.subtitle = "You might have some things to do 🤭"
//        content.body = "\(passedTaskItem.name!), due for: \(passedTaskItem.dueDate!)"
//        content.sound = UNNotificationSound.default
//
//        // Configure recurring date:
//        let calendar = Calendar.current
//
//        // Notify 1 hour before deadline:
//        let justBeforDueDate = calendar.date(byAdding: .hour, value: -1, to: passedTaskItem.dueDate ?? Date())
//        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: justBeforDueDate ?? Date())
//
//        // Show this notification five seconds from now:
////                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//        // Create a trigger as a repeating event:
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//
//        // Choose a random identifier and create the request:
//        let uuidString = UUID().uuidString
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
////                let request = UNNotificationRequest(identifier: passedTaskItem.id?.uuidString ?? uuidString, content: content, trigger: trigger)
//
//        // Add notification request:
////                UNUserNotificationCenter.current().add(request)
//        let notificationCenter = UNUserNotificationCenter.current()
//        notificationCenter.add(request) { (error) in
//            if error != nil {
//                // Handle any error here
//            }
//        }
//    }
//}
//
//struct NotifcationsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NotifcationsView(passedTaskItem: TaskItem())
//            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
