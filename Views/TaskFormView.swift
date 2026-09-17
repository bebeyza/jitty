//
//  TaskFormView.swift
//  BrandNewProject
//

import SwiftUI

/// A small reusable sheet for creating or editing a task.
struct TaskFormView: View {
    private let originalTask: BoardTask?
    let onSave: (BoardTask) -> Void
    let onDelete: (() -> Void)?

    @Environment(\.dismiss) private var dismiss
    @State private var title: String
    @State private var detail: String
    @State private var assignee: String
    @State private var priority: BoardTask.Priority
    @State private var isConfirmingDeletion = false

    init(
        task: BoardTask? = nil,
        onSave: @escaping (BoardTask) -> Void,
        onDelete: (() -> Void)? = nil
    ) {
        originalTask = task
        self.onSave = onSave
        self.onDelete = onDelete
        _title = State(initialValue: task?.title ?? "")
        _detail = State(initialValue: task?.detail ?? "")
        _assignee = State(initialValue: task?.assignee ?? "")
        _priority = State(initialValue: task?.priority ?? .medium)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Task") {
                    TextField("Title", text: $title)
                    TextField("Description (optional)", text: $detail, axis: .vertical)
                        .lineLimit(3...6)
                }

                Section("Details") {
                    TextField("Assignee (optional)", text: $assignee)

                    Picker("Priority", selection: $priority) {
                        ForEach(BoardTask.Priority.allCases, id: \.self) { priority in
                            Text(priority.rawValue).tag(priority)
                        }
                    }
                }
            }
            .navigationTitle(originalTask == nil ? "New Task" : "Edit Task")
            .toolbar {
                ToolbarItem {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem {
                    Button(originalTask == nil ? "Add" : "Save") {
                        let task = BoardTask(
                            id: originalTask?.id ?? UUID(),
                            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
                            detail: detail.trimmingCharacters(in: .whitespacesAndNewlines),
                            assignee: assignee.trimmingCharacters(in: .whitespacesAndNewlines).nilIfEmpty,
                            dueDate: originalTask?.dueDate,
                            priority: priority
                        )
                        onSave(task)
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }

                if onDelete != nil {
                    ToolbarItem {
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            isConfirmingDeletion = true
                        }
                    }
                }
            }
            .confirmationDialog("Delete task?", isPresented: $isConfirmingDeletion, titleVisibility: .visible) {
                Button("Delete", role: .destructive) {
                    onDelete?()
                    dismiss()
                }
            } message: {
                Text("This permanently removes the task from the board.")
            }
        }
    }
}

private extension String {
    var nilIfEmpty: String? {
        isEmpty ? nil : self
    }
}

#Preview {
    TaskFormView(onSave: { _ in })
}
