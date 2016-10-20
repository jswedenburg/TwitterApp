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
    
    @IBOutlet weak var followButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func setupImages(){
        let bottomRightMaskLayer = CAShapeLayer()
        bottomRightMaskLayer.path = UIBezierPath(roundedRect: bottomRightImage.bounds, byRoundingCorners: [.bottomRight], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        bottomRightImage.layer.mask = bottomRightMaskLayer
        
        let topLeftMaskLayer = CAShapeLayer()
        topLeftMaskLayer.path = UIBezierPath(roundedRect: topLeftImage.bounds, byRoundingCorners: [.topLeft], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        topLeftImage.layer.mask = topLeftMaskLayer
        
        let bottomLeftMaskLayer = CAShapeLayer()
        bottomLeftMaskLayer.path = UIBezierPath(roundedRect: bottomLeftImage.bounds, byRoundingCorners: [.bottomLeft], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        bottomLeftImage.layer.mask = bottomLeftMaskLayer
        
        let topRightMaskLayer = CAShapeLayer()
        topRightMaskLayer.path = UIBezierPath(roundedRect: topRightImage.bounds, byRoundingCorners: [.topRight], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        topRightImage.layer.mask = topRightMaskLayer
        
       
        
        
        
        
    }
    
    @IBAction func cellButtonPressed(_ sender: AnyObject) {
        delegate?.cellButtonPressed(sender: self)
    }
    
    //MARK: Helper Functions
    
    func updateWithSchedule(schedule: Schedule, accounts: [TwitterAccount]) {
        
        
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
        
        setupImages()
        
        
    }
}
