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

    var tasks: [Task] = [
            Task(title: "Example Task", description: "This is a default task to verify functionality.", isCompleted: false)
        ]

    func addTask(title: String) {
        // Add a task with placeholder values for now
        tasks.append(Task(title: title, description: "", isCompleted: false))
        print("Tasks array: \(tasks)") // Debugging: Verify tasks array
    }

    func toggleTaskCompletion(at index: Int, onComplete: (Task) -> Void) {
        tasks[index].isCompleted.toggle()
        let completedTask = tasks.remove(at: index)
        onComplete(completedTask) // Call the closure with the completed task
    }

    func removeTask(at index: Int) {
        tasks.remove(at: index)
    }
}
