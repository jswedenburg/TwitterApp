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
    
    //MARK: Outlets
    @IBOutlet weak var topLeftImage: UIImageView!
    @IBOutlet weak var topRightImage: UIImageView!
    @IBOutlet weak var bottomLeftImage: UIImageView!
    @IBOutlet weak var bottomRightImage: UIImageView!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageContainer: UIView!
    
    //MARK: Propeties
    var delegate: TableViewCellDelegate?
    
    //MARK: Actions
    @IBAction func cellButtonPressed(_ sender: AnyObject) {
        delegate?.cellButtonPressed(sender: self)
    }
    
    //MARK: Helper Functions
    func updateWithSchedule(schedule: Schedule, accounts: [TwitterAccount]) {
        self.titleLabel.text = schedule.title
        self.imageContainer.layer.cornerRadius = 10.0
        switch accounts.count {
        case 1:
            self.topRightImage.image = UIImage(data: accounts[0].profileImage as! Data)
            self.topLeftImage.image = UIImage(data: accounts[0].profileImage as! Data)
            self.bottomLeftImage.image = UIImage(data: accounts[0].profileImage as! Data)
            self.bottomRightImage.image = UIImage(data: accounts[0].profileImage as! Data)
        case 2:
            self.topRightImage.image = UIImage(data: accounts[0].profileImage as! Data)
            self.topLeftImage.image = UIImage(data: accounts[1].profileImage as! Data)
            self.bottomLeftImage.image = UIImage(data: accounts[0].profileImage as! Data)
            self.bottomRightImage.image = UIImage(data: accounts[1].profileImage as! Data)
        case 3:
            self.topRightImage.image = UIImage(data: accounts[0].profileImage as! Data)
            self.topLeftImage.image = UIImage(data: accounts[1].profileImage as! Data)
            self.bottomLeftImage.image = UIImage(data: accounts[2].profileImage as! Data)
            self.bottomRightImage.image = UIImage(data: accounts[0].profileImage as! Data)
        default:
            self.topRightImage.image = UIImage(data: accounts[0].profileImage as! Data)
            self.topLeftImage.image = UIImage(data: accounts[1].profileImage as! Data)
            self.bottomLeftImage.image = UIImage(data: accounts[2].profileImage as! Data)
            self.bottomRightImage.image = UIImage(data: accounts[3].profileImage as! Data)
        }
        
       
    }

}
