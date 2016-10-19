//
//  ScheduleTableViewCell.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/6/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit
import GameKit

class ScheduleTableViewCell: UITableViewCell{
    
    var delegate: TableViewCellDelegate?

    @IBOutlet weak var topLeftImage: UIImageView!
    @IBOutlet weak var topRightImage: UIImageView!
    @IBOutlet weak var bottomLeftImage: UIImageView!
    @IBOutlet weak var bottomRightImage: UIImageView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var timeAndDateLabel: UILabel!
    
    @IBAction func cellButtonPressed(_ sender: AnyObject) {
        delegate?.cellButtonPressed(sender: self)
    }
    
    //MARK: Helper Functions
    
    func updateWithSchedule(schedule: Schedule, dayLabelText: String, accounts: [TwitterAccount]) {
        self.titleLabel.text = schedule.title
        
        if accounts.count > 0 {
            
                let randomNumber1 = GKRandomSource.sharedRandom().nextInt(upperBound: accounts.count)
                let randomNumber2 = GKRandomSource.sharedRandom().nextInt(upperBound: accounts.count)
                let randomNumber3 = GKRandomSource.sharedRandom().nextInt(upperBound: accounts.count)
                let randomNumber4 = GKRandomSource.sharedRandom().nextInt(upperBound: accounts.count)
                
                self.topRightImage.image = UIImage(data: accounts[randomNumber1].profileImage!) ?? #imageLiteral(resourceName: "followMan")
                self.topLeftImage.image = UIImage(data: accounts[randomNumber2].profileImage!) ?? #imageLiteral(resourceName: "followMan")
                self.bottomLeftImage.image = UIImage(data: accounts[randomNumber3].profileImage!) ?? #imageLiteral(resourceName: "followMan")
                self.bottomRightImage.image = UIImage(data: accounts[randomNumber4].profileImage!) ?? #imageLiteral(resourceName: "followMan")
            
        }
        
        
       
        if schedule.repeating {
            self.timeAndDateLabel.text = dayLabelText
        }else {
            self.timeAndDateLabel.text = setDateLabel(date1: schedule.startTime!, date2: schedule.endTime!)
            
        }
        
        
    }
    
    func setDateLabel(date1: Date, date2: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        let string1 = formatter.string(from: date1)
        let string2 = formatter.string(from: date2)
        
        return string1 + " " + "-" + " " + string2
        
    }
}
