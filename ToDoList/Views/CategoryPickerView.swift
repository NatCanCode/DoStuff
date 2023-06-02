//
//  PriorityPickerView.swift
//  ToDoList
//
//  Created by N N on 28/02/2023.
//

import SwiftUI

struct CategoryPickerView: View {

    @Binding var category: Category

    var body: some View {
        Picker("Priority", selection: $category) {
            ForEach(Category.allCases) { category in
                Text(category.rawValue).tag(category)
            }
        }
        .pickerStyle(.segmented)
        .accessibilityIdentifier("Category Picker")
    }
}

struct CategoryPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryPickerView(category: .constant(.work))
    }
}
