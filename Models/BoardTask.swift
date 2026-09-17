//
//  BoardTask.swift
//  BrandNewProject
//

import Foundation

/// One piece of work on a board.
struct BoardTask: Identifiable, Hashable, Codable {
    let id: UUID
    var title: String
    var detail: String
    var assignee: String?
    var dueDate: Date?
    var priority: Priority

    enum Priority: String, CaseIterable, Codable {
        case low = "Low"
        case medium = "Medium"
        case high = "High"
    }

    init(
        id: UUID = UUID(),
        title: String,
        detail: String = "",
        assignee: String? = nil,
        dueDate: Date? = nil,
        priority: Priority = .medium
    ) {
        self.id = id
        self.title = title
        self.detail = detail
        self.assignee = assignee
        self.dueDate = dueDate
        self.priority = priority
    }
}
