//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by N N on 05/01/2023.
//

import SwiftUI

@main
struct ToDoListApp: App {

    private let notificationManager = NotificationManager()
        init() {
            setupNotifications()
        }

    // Needed for the UI Tests:
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    let persistenceController = PersistenceController.shared
    @StateObject var viewModel = ViewModel()

    var body: some Scene {
        WindowGroup {
            TaskListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(viewModel)
//                .onAppear {
//                    NotificationManager.shared.requestAuthorization()
//                }
        }
    }

    private func setupNotifications() {
            notificationManager.notificationCenter.delegate = notificationManager
            notificationManager.handleNotification = handleNotification

            requestNotificationsPermission()
        }

        private func handleNotification(notification: UNNotification) {
            print("<<<DEV>>> Notification received: (notification.request.content.userInfo)")
        }

        private func requestNotificationsPermission() {
            notificationManager.requestPermission(completionHandler: { isGranted, error in
                if isGranted {
                   print("User notification authorization: success ✅")
                }
                if error != nil {
                    print("User notification authorization error: (error.localizedDescription)")
                    return
                }
            })
        }
}

// Displays whether IU Test is running (true/false) on the console:
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        #if DEBUG
        print("👩‍💻 is UI Test running: \(UITestingHelper.isUITesting)")
        #endif
        return true
    }
}
