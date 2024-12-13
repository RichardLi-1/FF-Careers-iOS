//
//  TaskTableViewCell.swift
//  FF Careers
//
//  Created by Richard Li on 2024-12-12.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    
    private var isChecked = false
    
    @IBAction func checkboxTapped(_ sender: UIButton) {
            isChecked.toggle()
            let imageName = isChecked ? "checkmark.square.fill" : "square"
            Check.setImage(UIImage(systemName: imageName), for: .normal)
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
        cell.taskNameLabel.text = tasks[indexPath.row]
        return cell
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
