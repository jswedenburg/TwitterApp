//
//  AccountCollectionViewCell.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/14/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit

class AccountCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var accountImage: UIImageView!
    
    @IBOutlet weak var screenNameLabel: UILabel!
    
    func updateWithAccount(account: TwitterAccount){
        self.screenNameLabel.text = "@" + (account.screenName ?? "")
        guard let data = account.profileImage else { return }
        self.accountImage.image = UIImage(data: data)
    }
    
    
}
