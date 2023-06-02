//
//  ArrayExtension.swift
//  ToDoList
//
//  Created by N N on 04/03/2023.
//

import Foundation

extension Array where Element: Equatable {

    // Remove  element from the collection:
    mutating func remove(_ element: Element) {
        guard let index = firstIndex(of: element) else { return }
        remove(at: index)
    }
}
