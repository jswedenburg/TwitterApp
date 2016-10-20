//
//  AccountCollectionViewCell.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/14/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit

class AccountCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var accountImage: UIImageView!
    
    
    func updateWithAccount(account: TwitterAccount){
        self.userNameLabel.text = "@" + (account.screenName ?? "")
        guard let data = account.profileImage else { return }
        self.accountImage.image = UIImage(data: data)
    }
    
    
}
