//
//  BoardColumn.swift
//  BrandNewProject
//

import Foundation

/// A workflow stage, such as "To Do" or "Done".
struct BoardColumn: Identifiable, Hashable, Codable {
    let id: UUID
    var title: String
    var tasks: [BoardTask]

    init(id: UUID = UUID(), title: String, tasks: [BoardTask] = []) {
        self.id = id
        self.title = title
        self.tasks = tasks
    }
}
