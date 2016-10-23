//
//  AccountCollectionViewCell.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/14/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit

class AccountCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var accountImageView: UIImageView!
    @IBOutlet weak var checkMarkImageView: UIImageView!
    
    
    
    func updateWithAccount(account: TwitterAccount){
        self.usernameLabel.text = "@" + (account.screenName ?? "")
        guard let data = account.profileImage else { return }
        self.accountImageView.image = UIImage(data: data)
        
        checkMarkImageView.layer.borderWidth = 0.5
        checkMarkImageView.layer.masksToBounds = false
        checkMarkImageView.layer.borderColor = UIColor.black.cgColor
        checkMarkImageView.layer.cornerRadius = 13
        checkMarkImageView.layer.cornerRadius = checkMarkImageView.frame.size.height/2
        checkMarkImageView.clipsToBounds = true
    }
    
    
}
