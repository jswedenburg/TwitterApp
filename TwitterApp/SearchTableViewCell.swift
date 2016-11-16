//
//  SearchTableViewCell.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/13/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var accountImageView: UIImageView!
    @IBOutlet weak var verifiedImageView: UIImageView!
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var accountScreenname: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    //MARK: Color Properties
    let twitterBlack = UIColor(red: CGFloat(20.0/255.0), green: CGFloat(23.0/255.0), blue: CGFloat(26.0/255.0), alpha: 1.0)
    let twitterBlue = UIColor(red: CGFloat(29.0/255.0), green: CGFloat(161.0/255.0), blue: CGFloat(242.0/255.0), alpha: 1.0)
    
    //MARK: Delegate Property
    var delegate: TableViewCellDelegate?
    
    //MARK: IBActions
    @IBAction func cellButtonPressed(_ sender: AnyObject) {
        delegate?.cellButtonPressed(sender: self)
    }
    
    //MARK: Helper Functions
    func updateWithAccount(account: TwitterAccount) {
        followButton.imageEdgeInsets = UIEdgeInsetsMake(25.0, 55.0, 25.0, 15.0)
        self.accountName.text = account.name
        self.accountScreenname.text = "@" + (account.screenName ?? "")
        guard let image = UIImage(data: account.profileImage! as Data) else { return }
        self.accountImageView.image = image
        if account.followed{
            followButton.setImage(#imageLiteral(resourceName: "bluecheckmark"), for: .normal)
        } else {
            followButton.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        }
        if account.verified {
            verifiedImageView.image = #imageLiteral(resourceName: "verified")
        } else {
            verifiedImageView.image = nil
        }
    }
}

//MARK: TableViewCellProtocol
protocol TableViewCellDelegate {
    func cellButtonPressed(sender: UITableViewCell)
}
