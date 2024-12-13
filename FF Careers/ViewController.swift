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
            // Ensure the task title is not empty
            guard let taskTitle = taskInputField.text, !taskTitle.isEmpty else { return }
            
            // Add the task with a title; other fields are blank
            TaskDatabase.shared.addTask(title: taskTitle)
            
            // Reload the table view and clear the input field
            tableView.reloadData()
            taskInputField.text = ""
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return TaskDatabase.shared.tasks.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
            let task = TaskDatabase.shared.tasks[indexPath.row]

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
            TaskDatabase.shared.toggleTaskCompletion(at: sender.tag)
            tableView.reloadData()
        }
    
}

