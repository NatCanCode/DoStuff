//
//  ContentView.swift
//  ToDoList
//
//  Created by N N on 05/01/2023.
//

import SwiftUI
import CoreData

struct TaskListView: View {
    // Refresh issue to sort out
    @EnvironmentObject var viewModel: ViewModel
    @State var selectedCategory = Category.family
    
    init() {
        // Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        // Use this if NavigationBarTitle is with displayMode = .inline
        // UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.red]
    }

    var body: some View {
        NavigationStack {
            VStack {
                DateScrollerView()
                    .padding()
                    .environmentObject(viewModel)
                ZStack {
                    if viewModel.filteredTaskItems().isEmpty {
                        NoItemView()
                            .transition(AnyTransition.opacity.animation(.easeIn))
                    } else {
                        List {
                            ForEach(viewModel.filteredTaskItems()) { item in
                                NavigationLink(destination: TaskEditView(task: item), label:
                                     {
                                        TaskCellView(passedTaskItem: item)
                                            .environmentObject(viewModel)
                                    })
                            }
                            .onDelete(perform: viewModel.deleteItems)
                        }
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                EditButton()
                                    .foregroundColor(.accentColor)
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Picker("", selection: $viewModel.selectedFilter) {
                                    ForEach(TaskFilter.allCases, id: \.self) { filter in
                                        Button {
                                            withAnimation {
                                                viewModel.selectedFilter = filter
                                                viewModel.fetchTasks()
                                            }
                                        } label: {
                                            Text(filter.rawValue)
                                        }
                                    }
                                }
                                .foregroundColor(.accentColor)
                                .accessibilityIdentifier("filterPicker")
                            }
                        }
                    }

                    FloatingButtonView()
                        .environmentObject(viewModel)
                }
            }
            .navigationTitle("My To Do List").accessibilityIdentifier("MyToDoList")
            .scrollContentBackground(.hidden)
            .background(Image("pink-pattern")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea())
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
