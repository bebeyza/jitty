//
//  ContentView.swift
//  BrandNewProject
//
//  Created by Beyza Avcı on 21.08.2026.
//

import SwiftUI

struct ContentView: View {
    // @State makes this view the single source of truth for the board.
    @State private var columns: [BoardColumn]

    init() {
        // On the first launch there is no saved board, so use our starter data.
        _columns = State(initialValue: LocalBoardStorage.loadColumns() ?? SampleBoard.columns)
    }

    var body: some View {
        NavigationStack {
            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(columns.indices, id: \.self) { index in
                        let column = columns[index]

                        BoardColumnView(
                            column: column,
                            canMoveBackward: index > columns.startIndex,
                            canMoveForward: index < columns.index(before: columns.endIndex),
                            onAddTask: { task in
                                add(task, to: column.id)
                            },
                            onEditTask: { task in
                                update(task, in: column.id)
                            },
                            onDeleteTask: { task in
                                delete(task, from: column.id)
                            },
                            onMoveBackward: { task in
                                move(task, from: column.id, by: -1)
                            },
                            onMoveForward: { task in
                                move(task, from: column.id, by: 1)
                            }
                        )
                    }
                }
                .padding()
            }
            // A semantic SwiftUI color works on every platform this app supports.
            .background(Color.primary.opacity(0.04))
            .navigationTitle(SampleBoard.name)
            .toolbar {
                // Let each platform place this action in its native toolbar location.
                ToolbarItem {
                    Button("Share board", systemImage: "person.2") {
                        // Collaboration is a later milestone.
                    }
                }
            }
        }
        // Saving here means every change to our source of truth is persisted.
        .onChange(of: columns) { _, newColumns in
            LocalBoardStorage.save(newColumns)
        }
    }

    private func add(_ task: BoardTask, to columnID: BoardColumn.ID) {
        guard let index = columns.firstIndex(where: { $0.id == columnID }) else { return }
        columns[index].tasks.append(task)
    }

    private func move(_ task: BoardTask, from sourceID: BoardColumn.ID, by offset: Int) {
        guard let sourceIndex = columns.firstIndex(where: { $0.id == sourceID }) else { return }

        let destinationIndex = sourceIndex + offset
        guard columns.indices.contains(destinationIndex) else { return }
        guard let taskIndex = columns[sourceIndex].tasks.firstIndex(of: task) else { return }

        let movedTask = columns[sourceIndex].tasks.remove(at: taskIndex)
        columns[destinationIndex].tasks.append(movedTask)
    }

    private func update(_ task: BoardTask, in columnID: BoardColumn.ID) {
        guard let columnIndex = columns.firstIndex(where: { $0.id == columnID }) else { return }
        guard let taskIndex = columns[columnIndex].tasks.firstIndex(where: { $0.id == task.id }) else { return }
        columns[columnIndex].tasks[taskIndex] = task
    }

    private func delete(_ task: BoardTask, from columnID: BoardColumn.ID) {
        guard let columnIndex = columns.firstIndex(where: { $0.id == columnID }) else { return }
        columns[columnIndex].tasks.removeAll { $0.id == task.id }
    }
}

#Preview {
    ContentView()
}
