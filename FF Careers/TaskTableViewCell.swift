//
//  TaskTableViewCell.swift
//  FF Careers
//
//  Created by Richard Li on 2024-12-12.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var taskLabel: UILabel!
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
