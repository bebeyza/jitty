# Jitty

Jitty is a small SwiftUI kanban board for organizing work across workflow columns. The current app ships with a sample Product launch board and stores changes locally on the device.

## Features

- View tasks grouped into To Do, In Progress, and Done columns
- Add new tasks with a title, description, assignee, and priority
- Edit or delete existing tasks
- Move tasks between adjacent columns
- Persist the board locally between launches with `UserDefaults` and JSON encoding

The Share board control is currently a placeholder for a future collaboration feature.

## Requirements

- macOS with Xcode 26.6 or later
- iOS, macOS, or visionOS simulator/device supported by the installed Xcode SDKs

The project currently uses Swift 5 and deployment targets of 26.5.

## Run Locally

1. Open `BrandNewProject.xcodeproj` in Xcode.
2. Select the `BrandNewProject` scheme.
3. Choose an available simulator or connected device.
4. Build and run with the Run button or `Command-R`.

Automatic signing is enabled for the app target. A development team may need to be selected in Xcode before running on a physical device.

## Project Structure

```text
BrandNewProject/
  BrandNewProjectApp.swift     App entry point
  ContentView.swift            Board screen and board state management
  Models/                      Board and task data models
  Data/                        Sample data and local persistence
  Views/                       Column, task card, and task form views
  Assets.xcassets/             App icon and accent color assets
BrandNewProject.xcodeproj/     Xcode project configuration
```

## Data Storage

The board is encoded as JSON and saved to the app's private `UserDefaults` storage under the `savedBoardColumns` key. A new installation starts with the sample board. If saved data cannot be decoded, the app falls back to the sample board.

## Current Limitations

- There is no cloud sync or collaboration yet.
- Board columns cannot currently be created, renamed, reordered, or deleted.
- There are no automated tests in the project yet.

## Repository

The canonical repository is https://github.com/bebeyza/jitty. App sources live in `BrandNewProject/`, matching the synchronized source group in the Xcode project. Shared Xcode settings can be committed; personal settings and build output are ignored.
