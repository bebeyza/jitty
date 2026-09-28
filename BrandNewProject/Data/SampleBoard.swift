//
//  SampleBoard.swift
//  BrandNewProject
//

import Foundation

/// Temporary local data keeps the first UI iteration focused.
/// We will replace this with a shared store when we add collaboration.
enum SampleBoard {
    static let name = "Product launch"

    static let columns: [BoardColumn] = [
        BoardColumn(title: "To Do", tasks: [
            BoardTask(title: "Draft launch checklist", detail: "List the work needed before launch.", assignee: "Beyza", priority: .high),
            BoardTask(title: "Invite the team", detail: "Share the board with the project team.", priority: .medium)
        ]),
        BoardColumn(title: "In Progress", tasks: [
            BoardTask(title: "Design the welcome screen", detail: "Keep it focused and friendly.", assignee: "Mert", priority: .high)
        ]),
        BoardColumn(title: "Done", tasks: [
            BoardTask(title: "Choose a project name", assignee: "Beyza", priority: .low)
        ])
    ]
}
