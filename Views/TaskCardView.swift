//
//  TaskCardView.swift
//  BrandNewProject
//

import SwiftUI

struct TaskCardView: View {
    let task: BoardTask
    let onTap: () -> Void
    var onMoveBackward: (() -> Void)?
    var onMoveForward: (() -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(task.title)
                .font(.headline)
                .foregroundStyle(.primary)

            if !task.detail.isEmpty {
                Text(task.detail)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }

            HStack {
                Text(task.priority.rawValue)
                    .font(.caption.weight(.semibold))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(priorityColor.opacity(0.15), in: Capsule())
                    .foregroundStyle(priorityColor)

                Spacer()

                if let assignee = task.assignee {
                    Label(assignee, systemImage: "person.circle.fill")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            if onMoveBackward != nil || onMoveForward != nil {
                Divider()

                HStack {
                    Spacer()

                    if let onMoveBackward {
                        Button("Move left", systemImage: "arrow.left") {
                            onMoveBackward()
                        }
                    }

                    if let onMoveForward {
                        Button("Move right", systemImage: "arrow.right") {
                            onMoveForward()
                        }
                    }
                }
                .font(.caption.weight(.semibold))
                .buttonStyle(.borderless)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.background, in: RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.06), radius: 8, y: 3)
        .contentShape(RoundedRectangle(cornerRadius: 16))
        .onTapGesture(perform: onTap)
    }

    private var priorityColor: Color {
        switch task.priority {
        case .low: .green
        case .medium: .orange
        case .high: .red
        }
    }
}

#Preview {
    TaskCardView(
        task: BoardTask(title: "Design the welcome screen", assignee: "Mert", priority: .high),
        onTap: {},
        onMoveBackward: {},
        onMoveForward: {}
    )
        .padding()
}
