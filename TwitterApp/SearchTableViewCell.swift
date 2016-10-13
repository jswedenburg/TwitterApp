//
//  SearchTableViewCell.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/13/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var accountImageView: UIImageView!
    @IBOutlet weak var verifiedImageView: UIImageView!
    
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var accountScreenname: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    var delegate: TableViewCellDelegate?
    
    @IBAction func followButtonPressed(_ sender: AnyObject) {
        delegate?.cellButtonPressed(sender: self)
    }
    
    func updateWithAccount(account: TwitterAccount) {
        self.accountName.text = account.name
        self.accountScreenname.text = account.screenName
        guard let image = UIImage(data: account.profileImage!) else { return }
        self.accountImageView.image = image
    }

}

protocol TableViewCellDelegate {
    func cellButtonPressed(sender: SearchTableViewCell)
}