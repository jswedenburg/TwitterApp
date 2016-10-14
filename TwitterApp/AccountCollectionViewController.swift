//
//  AccountCollectionViewController.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/7/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit

private let reuseIdentifier = "accountCell"

class AccountCollectionViewController: UICollectionViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }



    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? AccountCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = UIColor.red
        cell.accountNameLabel.text = "test"
    
    
        return cell
    }

}
