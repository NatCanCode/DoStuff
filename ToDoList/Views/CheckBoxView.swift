//
//  CheckBoxView.swift
//  ToDoList
//
//  Created by N N on 05/01/2023.
//

import SwiftUI

struct CheckBoxView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var viewModel: ViewModel
    @ObservedObject var passedTaskItem: TaskItem
    
    var body: some View {
        Image(systemName: passedTaskItem.isDone ? "checkmark.square.fill" : "square")
            .foregroundColor(passedTaskItem.isDone ? .accentColor : .secondary)
            .onTapGesture {
                withAnimation {
                    viewModel.toggleTaskValidation(task: passedTaskItem)
                }
            }
            .accessibilityIdentifier("Checkmark test")
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxView(passedTaskItem: TaskItem())
    }
}
