//
//  TwitterSearchTableViewController.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/11/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit
import TwitterKit
class TwitterSearchTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TableViewCellDelegate, UISearchBarDelegate {
    
    var schedule: Schedule?
    static var delegate: searchDelegate?
    
    @IBOutlet weak var searchBar: CustomSearchBar!
    
    let twitterBlack = UIColor(red: CGFloat(20.0/255.0), green: CGFloat(23.0/255.0), blue: CGFloat(26.0/255.0), alpha: 1.0)
    let twitterBlue = UIColor(red: CGFloat(29.0/255.0), green: CGFloat(161.0/255.0), blue: CGFloat(242.0/255.0), alpha: 1.0)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        
        
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var followedAccounts: [TwitterAccount] = []
    
    var twitterAccounts: [TwitterAccount] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
   
    
        
    
    
    
    //MARK: Search Delegate
    
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        NetworkController.searchRequest(searchTerm: searchTerm) { (accounts) in
            self.twitterAccounts = accounts
        }
        
        
        self.searchBar.endEditing(true)
       
    }
    
    func cellButtonPressed(sender: UITableViewCell) {
        
        guard let sender = sender as? SearchTableViewCell else { return }
        guard let index = self.tableView.indexPath(for: sender) else { return }
        let account = twitterAccounts[index.row]
        if followedAccounts.contains(account) {
            guard let index = followedAccounts.index(of: account) else { return }
            followedAccounts.remove(at: index)
            sender.followButton.setTitleColor(twitterBlack, for: .normal)
        } else {
            followedAccounts.append(account)
            sender.followButton.setTitleColor(twitterBlue, for: .normal)
        }
    }
    
    
    
    @IBAction func exitButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true) {
            for account in self.followedAccounts {
                let contains = TwitterSearchTableViewController.delegate?.accountArray.contains(where: {account.screenName == $0.screenName})
                guard let append = contains else { return }
                if append {
                    
                } else {
                    TwitterSearchTableViewController.delegate?.accountArray.append(account)
                }
            }
            
        }
    }
    
    
    // MARK: - Table view data source
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twitterAccounts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        let account = twitterAccounts[indexPath.row]
        cell.updateWithAccount(account: account)
        
        
        
        return cell
    }
    
    
    

}


protocol searchDelegate {
    var accountArray: [TwitterAccount] { get set }
}
