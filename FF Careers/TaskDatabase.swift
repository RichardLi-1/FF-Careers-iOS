//
//  TaskDatabase.swift
//  FF Careers
//
//  Created by Richard Li on 2024-12-13.
//

import Foundation

struct Task {
    var title: String
    var description: String
    var isCompleted: Bool
}

class TaskDatabase {
    static let shared = TaskDatabase() // Singleton instance
    private init() {}

    var tasks: [Task] = []

    func addTask(title: String) {
        // Add a task with placeholder values for now
        tasks.append(Task(title: title, description: "", isCompleted: false))
    }

    func toggleTaskCompletion(at index: Int) {
        tasks[index].isCompleted.toggle()
    }

    func removeTask(at index: Int) {
        tasks.remove(at: index)
    }
}
