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
    var dayIncluded = false
    

    func updateWithRow(row: Int) {
        checkMarkImage.image = #imageLiteral(resourceName: "checkmark")
        switch row {
        case 0:
            dayLabel.text = "Sunday"
        case 1:
            dayLabel.text = "Monday"
        case 2:
            dayLabel.text = "Tuesday"
        case 3:
            dayLabel.text = "Wednesday"
        case 4:
            dayLabel.text = "Thursday"
        case 5:
            dayLabel.text = "Friday"
        case 6:
            dayLabel.text = "Saturday"
        default:
            print("Wrong Index")
            
        }
    }

}
