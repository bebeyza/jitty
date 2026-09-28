//
//  BoardColumnView.swift
//  BrandNewProject
//

import SwiftUI

struct BoardColumnView: View {
    let column: BoardColumn
    let canMoveBackward: Bool
    let canMoveForward: Bool
    let onAddTask: (BoardTask) -> Void
    let onEditTask: (BoardTask) -> Void
    let onDeleteTask: (BoardTask) -> Void
    let onMoveBackward: (BoardTask) -> Void
    let onMoveForward: (BoardTask) -> Void

    @State private var isPresentingTaskForm = false
    @State private var taskBeingEdited: BoardTask?

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text(column.title)
                    .font(.headline)

                Text("\(column.tasks.count)")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)
                    .padding(6)
                    .background(.quaternary, in: Circle())
            }

            ForEach(column.tasks) { task in
                TaskCardView(
                    task: task,
                    onTap: { taskBeingEdited = task },
                    onMoveBackward: canMoveBackward ? { onMoveBackward(task) } : nil,
                    onMoveForward: canMoveForward ? { onMoveForward(task) } : nil
                )
            }

            Button("Add task", systemImage: "plus") {
                isPresentingTaskForm = true
            }
            .font(.subheadline.weight(.semibold))
            .buttonStyle(.borderless)
            .foregroundStyle(.tint)
        }
        .padding()
        .frame(width: 280, alignment: .topLeading)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20))
        .sheet(isPresented: $isPresentingTaskForm) {
            TaskFormView { task in
                onAddTask(task)
            }
        }
        .sheet(item: $taskBeingEdited) { task in
            TaskFormView(
                task: task,
                onSave: { updatedTask in
                    onEditTask(updatedTask)
                },
                onDelete: {
                    onDeleteTask(task)
                }
            )
        }
    }
}

#Preview {
    BoardColumnView(
        column: SampleBoard.columns[0],
        canMoveBackward: false,
        canMoveForward: true,
        onAddTask: { _ in },
        onEditTask: { _ in },
        onDeleteTask: { _ in },
        onMoveBackward: { _ in },
        onMoveForward: { _ in }
    )
        .padding()
}
