//
//  ScheduleTableViewCell.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/6/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var scheduleImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var timeAndDateLabel: UILabel!
    @IBOutlet weak var enabledSwitch: UISwitch!
    
    //MARK: Helper Functions
    
    func updateWithSchedule(schedule: Schedule) {
        
        self.titleLabel.text = schedule.title
        self.timeAndDateLabel.text = "9:00 AM - 9:00PM"
        self.enabledSwitch.isOn = schedule.enabled
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
