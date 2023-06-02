//
//  UITestingHelper.swift
//  ToDoList
//
//  Created by N N on 02/03/2023.
//  Check out Tunde Adegoroye's content

#if DEBUG

import Foundation

struct UITestingHelper {
    static var isUITesting: Bool {
        ProcessInfo.processInfo.arguments.contains("-ui-testing")
    }
}

#endif
