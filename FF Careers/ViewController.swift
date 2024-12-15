//
//  ViewController.swift
//  FF Careers
//
//  Created by Richard Li on 2024-12-09.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var taskInputField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    let selectedCategory = "General"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
                
                // Optional: Customize table view appearance
        tableView.tableFooterView = UIView() // Removes extra empty rows
    }
    

    
    @IBAction func addTaskButtonTapped(_ sender: UIButton) {
        print("Add Task button pressed")
            // Ensure the task title is not empty
            guard let taskTitle = taskInputField.text, !taskTitle.isEmpty else { return }
            
            // Add the task with a title; other fields are blank
            TaskDatabase.shared.addTask(title: taskTitle)
            
            // Reload the table view and clear the input field
            tableView.reloadData()
            print("Reloading table view")
            taskInputField.text = ""
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            print("Number of rows: \(TaskDatabase.shared.tasks.count)") // Debugging
            return TaskDatabase.shared.tasks.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
            let task = TaskDatabase.shared.tasks[indexPath.row]
            print("Configuring cell for task: \(task.title)")

            // Configure the cell
            cell.taskLabel.text = task.title
            let imageName = task.isCompleted ? "checkmark.square.fill" : "square"
            cell.checkboxButton.setImage(UIImage(systemName: imageName), for: .normal)
            cell.checkboxButton.tag = indexPath.row
            cell.checkboxButton.addTarget(self, action: #selector(toggleTaskCompletion(_:)), for: .touchUpInside)

            // Style the cell
                cell.backgroundColor = .clear // Transparent background for the cell itself
                cell.contentView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.8) // Translucent background
                cell.contentView.layer.cornerRadius = 10 // Rounded corners for the content
                cell.contentView.layer.masksToBounds = true // Clip content to rounded corners
                cell.layer.masksToBounds = false // Avoid clipping shadows if needed
                cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
            
            return cell
        }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let spacer = UIView()
        spacer.backgroundColor = .clear // Ensure the spacer is invisible
        return spacer
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10 // Adjust the spacing height as needed
    }

    @objc func toggleTaskCompletion(_ sender: UIButton) {
        let index = sender.tag

        // Toggle the task's completion state and provide the closure
        TaskDatabase.shared.toggleTaskCompletion(at: index) { completedTask in
            self.askProbingQuestion(for: completedTask)
        }

        // Add a 1-second delay before removing the task
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.removeTask(at: index)
        }
    }

    func removeTask(at index: Int) {
        // Remove the task and trigger probing question
        let completedTask = TaskDatabase.shared.tasks.remove(at: index)
        askProbingQuestion(for: completedTask)

        // Animate the removal
        tableView.performBatchUpdates({
            tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
        }, completion: nil)
    }

    
    func askProbingQuestion(for task: Task) {
        let alertController = UIAlertController(
            title: "Congrats on finishing \(task.title)!",
            message: "How much did you enjoy doing it?",
            preferredStyle: .alert
        )

        // Add a text field for feedback (optional)
        alertController.addTextField { textField in
            textField.placeholder = "Your feedback here..."
        }

        // Add star rating options
        for i in 1...5 {
            alertController.addAction(UIAlertAction(title: "⭐️ \(i)", style: .default) { _ in
                print("User rated \(i) stars for task \(task.title)")
            })
        }

        // Add a submit button to handle text feedback
        alertController.addAction(UIAlertAction(title: "Submit", style: .default) { [weak alertController] _ in
            if let feedback = alertController?.textFields?.first?.text {
                print("User feedback: \(feedback)")
            }
        })

        // Present the alert
        present(alertController, animated: true)
    }
    
}

