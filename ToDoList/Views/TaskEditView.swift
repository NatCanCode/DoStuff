//
//  TaskEditView.swift
//  ToDoList
//
//  Created by N N on 05/01/2023.
//

import SwiftUI
import UserNotifications

struct TaskEditView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme

    var task: TaskItem
    @State var name: String = ""
    @State var dueDate: Date = Date.now
    @State var scheduleTime: Bool = false
    @State var selectedCategory: Category = .family

    let now = Date.now

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Task").foregroundColor(colorScheme == .dark ? .black : .black)) {
                    TextField("Just name it!", text: $name)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .accessibilityIdentifier("Textfield")
                }
                .accessibilityIdentifier("Section Header")

                Section(header: Text("Category").foregroundColor(colorScheme == .dark ? .black : .black)) {
                    CategoryPickerView(category: $selectedCategory)
                }
                
                Section(header: Text("Due Date").foregroundColor(colorScheme == .dark ? .black : .black)) {
                    Toggle("Schedule Time", isOn: $scheduleTime)
                        .tint(.accentColor)
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: displayComps())
                }
                
                if task.isDone {
                    Section(header: Text("Completed")) {
                        Text(task.completedDate?.formatted(date: .abbreviated, time: .shortened) ?? "")
                            .foregroundColor(.accentColor)
                    }
                }
            }

            Button(viewModel.taskState.rawValue) {
                if let selectedTask = viewModel.selectedTask,
                    let id = selectedTask.id,
                    let createdDate = selectedTask.createdDate {
                    viewModel.updateTask(id: id, createdDate: createdDate, name: name, dueDate: dueDate, scheduleTime: scheduleTime, selectedCategory: selectedCategory)
                }

                dismiss()
            }
            .font(.headline)
            .padding(15)
            .padding(.horizontal,30)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(30)
            .shadow(
                color: Color.accentColor.opacity(0.7),
                radius: 30,
                x: 0,
                y: 30)
            // Disable Save Button if task name not entered:
            .disabled(name == "")
            .accessibilityIdentifier("Save button")
        }
        .padding(.bottom, 50)
        .navigationTitle("Add task")
        .scrollContentBackground(.hidden)
        .background(Image("pink-pattern")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea())
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                ShareLink(item: name, subject: Text("To do"), message: Text("Hey 👋 Check your Do Stuff App! '\(name)' is to be completed by \(dueDate.medium)")) {
                    Label("Tap to share task", systemImage:  "square.and.arrow.up")
                }
                .foregroundColor(.accentColor)
                .accessibilityIdentifier("Share")
            }
        }
        .onAppear {
            viewModel.taskState = .updating
            viewModel.selectedTask = task
            if let selectedTask = viewModel.selectedTask {
                    name = selectedTask.name ?? ""
                    dueDate = selectedTask.dueDate ?? Date()
                    scheduleTime = selectedTask.scheduleTime
                    selectedCategory = selectedTask.selectedCategory
            }
        }
    }
    
    func displayComps() -> DatePickerComponents {
        return scheduleTime ? [.hourAndMinute, .date] : [.date]
    }
}

struct TaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        TaskEditView(task: TaskItem(context: CoreDataManager.shared.container.viewContext))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
