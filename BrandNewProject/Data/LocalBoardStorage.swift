//
//  LocalBoardStorage.swift
//  BrandNewProject
//

import Foundation

/// Saves the board as JSON in the app's private UserDefaults storage.
/// This is appropriate for a small, single-device board; a later sync layer
/// can replace this without changing the UI code.
enum LocalBoardStorage {
    private static let columnsKey = "savedBoardColumns"

    static func loadColumns() -> [BoardColumn]? {
        guard let data = UserDefaults.standard.data(forKey: columnsKey) else {
            return nil
        }

        do {
            return try JSONDecoder().decode([BoardColumn].self, from: data)
        } catch {
            // If an old or damaged value cannot be read, start safely with sample data.
            return nil
        }
    }

    static func save(_ columns: [BoardColumn]) {
        do {
            let data = try JSONEncoder().encode(columns)
            UserDefaults.standard.set(data, forKey: columnsKey)
        } catch {
            assertionFailure("Could not save the board: \(error.localizedDescription)")
        }
    }
}
