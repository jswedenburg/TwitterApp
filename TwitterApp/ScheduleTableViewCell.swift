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
//        if accounts.count > 0 {
//            var x = 4
//            var randomNumbers: [Int] = []
//            while x > 0 {
//                print(x)
//                let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: accounts.count)
//                if randomNumbers.contains(randomNumber) {
//                    if accounts.count <= x {
//                        x -= 1
//                        //let randomNumber1 = GKRandomSource.sharedRandom().nextInt(upperBound: accounts.count)
//                        randomNumbers.append(0)
//                    }
//                } else {
//                    randomNumbers.append(randomNumber)
//                    x -= 1
//                }
//                print(x)
//            }
        
            
//            let randomNumber1 = GKRandomSource.sharedRandom().nextInt(upperBound: accounts.count)
//            let randomNumber2 = GKRandomSource.sharedRandom().nextInt(upperBound: accounts.count)
//            let randomNumber3 = GKRandomSource.sharedRandom().nextInt(upperBound: accounts.count)
//            let randomNumber4 = GKRandomSource.sharedRandom().nextInt(upperBound: accounts.count)
            
            
            
            self.topRightImage.image = UIImage(data: accounts[0].profileImage! as Data) ?? #imageLiteral(resourceName: "egg")
            self.topLeftImage.image = UIImage(data: accounts[1].profileImage! as Data) ?? #imageLiteral(resourceName: "egg")
            self.bottomLeftImage.image = UIImage(data: accounts[2].profileImage! as Data) ?? #imageLiteral(resourceName: "egg")
            self.bottomRightImage.image = UIImage(data: accounts[3].profileImage! as Data) ?? #imageLiteral(resourceName: "egg")
        }
    }
}
