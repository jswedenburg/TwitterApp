//
//  DayTableViewCell.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/10/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit

class DayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var checkMarkImage: UIImageView!
    
    

    func updateWithRow(row: Int, included: Bool) {
        checkMarkImage.image = #imageLiteral(resourceName: "checkmark")
        switch (row, included) {
        case (0, true):
            dayLabel.text = "Sunday"
            checkMarkImage.isHidden = false
        case (0, false):
            dayLabel.text = "Sunday"
            checkMarkImage.isHidden = true
        case (1, true):
            dayLabel.text = "Monday"
            checkMarkImage.isHidden = false
        case (1, false):
            dayLabel.text = "Monday"
            checkMarkImage.isHidden = true
        case (2, true):
            dayLabel.text = "Tuesday"
            checkMarkImage.isHidden = false
        case (2, false):
            dayLabel.text = "Tuesday"
            checkMarkImage.isHidden = true
        case (3, true):
            dayLabel.text = "Wednesday"
            checkMarkImage.isHidden = false
        case (3, false):
            dayLabel.text = "Wednesday"
            checkMarkImage.isHidden = true
        case (4, true):
            dayLabel.text = "Thursday"
            checkMarkImage.isHidden = false
        case (4, false):
            dayLabel.text = "Thursday"
            checkMarkImage.isHidden = true
        case (5, true):
            dayLabel.text = "Friday"
            checkMarkImage.isHidden = false
        case (5, false):
            dayLabel.text = "Friday"
            checkMarkImage.isHidden = true
        case (6, true):
            dayLabel.text = "Saturday"
            checkMarkImage.isHidden = false
        case (6, false):
            dayLabel.text = "Saturday"
            checkMarkImage.isHidden = true
        
        default:
            print("Wrong Index")
            
        }
    }

}
