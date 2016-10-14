//
//  TwitterSearchTableViewController.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/11/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit

class TwitterSearchTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TableViewCellDelegate {
    
    var schedule: Schedule?
    static var delegate: searchDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        NetworkController.twitterSearch(searchTerm: "nfl") { (accounts) in
            self.twitterAccounts = accounts
        }
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var followedAccounts: [TwitterAccount] = []
    
    var twitterAccounts: [TwitterAccount] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    
    
    
    func cellButtonPressed(sender: SearchTableViewCell) {
        guard let index = self.tableView.indexPath(for: sender) else { return }
        let account = twitterAccounts[index.row]
        followedAccounts.append(account)
        
        /*
        if let followedAccountIndex = twitterAccounts.index(where: { (account) -> Bool in
            account.screenName == sender.accountScreenname.text
        }) {
            let followedAccount = twitterAccounts[followedAccountIndex]
            followedAccounts.append(followedAccount)

        }
 
 */
            }
    
    
    
    @IBAction func exitButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true) { 
            TwitterSearchTableViewController.delegate?.accountArray = self.followedAccounts
        }
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twitterAccounts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        let account = twitterAccounts[indexPath.row]
        cell.updateWithAccount(account: account)
        

        return cell
    }
}

protocol searchDelegate {
    var accountArray: [TwitterAccount] { get set }
}
