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
    
    func updateWithSchedule(schedule: Schedule, dayLabelText: String) {
        
       
        if schedule.repeating {
            self.timeAndDateLabel.text = dayLabelText
        }else {
            self.timeAndDateLabel.text = setDateLabel(date1: schedule.startTime!, date2: schedule.endTime!)
            
        }
        
        self.enabledSwitch.isOn = schedule.enabled
    }
    
    func setDateLabel(date1: Date, date2: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        let string1 = formatter.string(from: date1)
        let string2 = formatter.string(from: date2)
        
        return string1 + " " + "-" + " " + string2
        
    }

    
        
    //TODO: Helper function to take in to take two Dates and the days and return the right String text

}
