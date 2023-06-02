//
//  Category.swift
//  ToDoList
//
//  Created by N N on 28/02/2023.
//

import SwiftUI
@objc

public enum Category: Int16, Identifiable, CaseIterable, RawRepresentable {
    public init?(rawValue: String) {
        switch rawValue {
        case "Family 👨‍👩‍👧‍👦":
            self = .family
        case "Work 💻":
            self = .work
        case "Leisure 🌿":
            self = .leisure
        case "other 📝":
            self = .other
        default:
            return nil
        }
    }

    public var rawValue: String {
        switch self {
        case .family:
            return "Family 👨‍👩‍👧‍👦"
        case .work:
            return "Work 💻"
        case .leisure:
            return "Leisure 🌿"
        case .other:
            return "Other 📝"
        }
    }

    public var id: UUID {
        return UUID()
    }
    case work
    case family
    case leisure
    case other

    public typealias RawValue = String

    public var symbol: String {
        switch self {
        case .family:
            return "👨‍👩‍👧‍👦"
        case .work:
            return "💻"
        case .leisure:
            return "🌿"
        case .other:
            return "📝"
        }
    }
}
