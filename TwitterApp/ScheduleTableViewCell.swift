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
        self.timeAndDateLabel.text = "9:00 AM - 9:00PM, every Sunday"
        self.enabledSwitch.isOn = schedule.enabled
    }

    
        
    //TODO: Helper function to take in to take two Dates and the days and return the right String text

}
