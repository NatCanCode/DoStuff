//
//  TaskCellView.swift
//  ToDoList
//
//  Created by N N on 05/01/2023.
//

import SwiftUI

struct TaskCellView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @ObservedObject var passedTaskItem: TaskItem
    
    var body: some View {
        HStack {
            CheckBoxView(passedTaskItem: passedTaskItem)
                .environmentObject(viewModel)

            Text(passedTaskItem.name?.capitalized ?? "")
                .padding(.horizontal)

            if !passedTaskItem.isCompleted() && passedTaskItem.scheduleTime {
                Spacer()
                Text(passedTaskItem.dueDateTimeOnly())
                    .font(.footnote)
                    .foregroundColor(passedTaskItem.overdueColor())
                    .padding(.horizontal)
            }
            Spacer()

            Text(passedTaskItem.selectedCategory.symbol)
        }
    }
}

struct TaskCellView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCellView(passedTaskItem: TaskItem())
    }
}
