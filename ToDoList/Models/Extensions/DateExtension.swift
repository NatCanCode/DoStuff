//
//  DateExtension.swift
//  ToDoList
//
//  Created by N N on 04/03/2023.
//

import Foundation

extension Date {

    var simpleDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: self)
    }

    var hourTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: self)
    }

    var isToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }

    var medium: String {
        self.formatted(date: .abbreviated, time: .shortened)
    }

    var short: String {
        self.formatted(date: .abbreviated, time: .omitted)
    }

    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }

    mutating func add(component: Calendar.Component, value: Int) {
        let calendar = Calendar.current
        self = calendar.date(byAdding: component, value: value, to: self) ?? Date()
    }

    func addingDate(component: Calendar.Component, value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: component, value: value, to: self) ?? Date()
    }

    var components: DateComponents {
        var dateComponents = DateComponents()

        let date = self.get(.day, .month, .year, .hour, .minute, .second)

        if let day = date.day,
           let month = date.month,
           let year = date.year,
           let hour = date.hour,
           let minute = date.minute,
           let second = date.second {
            dateComponents.day = day
            dateComponents.month = month
            dateComponents.year = year
            dateComponents.hour = hour
            dateComponents.minute = minute
            dateComponents.second = second
        }
        return dateComponents
    }
}
