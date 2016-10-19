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
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        //tap.delegate = self.view
        //self.view.addGestureRecognizer(tap)
        
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var followedAccounts: [TwitterAccount] = []
    
    var twitterAccounts: [TwitterAccount] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    /* HOW TO DO A TAP GESTURE?????
     let tap  = UITapGestureRecognizer(target: self, action: #selector(handleTap))
     
     
     func handleTap(sender: UITapGestureRecognizer? = nil) {
     self.resignFirstResponder()
     }
     */
    
    
    //MARK: Search Delegate
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, let userID = Twitter.sharedInstance().sessionStore.session()?.userID else { return }
        var accounts: [TwitterAccount] = []
        let client = TWTRAPIClient(userID: userID)
        let searchEndPoint = "https://api.twitter.com/1.1/users/search.json"
        let params = ["q": "\(searchTerm)", "page": "1", "count": "1"]
        var clientError: NSErrorPointer
        
        let request = client.urlRequest(withMethod: "GET", url: searchEndPoint, parameters: params, error: clientError)
        client.sendTwitterRequest(request) { (response, data, error) in
            guard let data = data else { return }
            
            guard let jsonDict = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [[String: Any]] else { return }
            for x in 0...jsonDict.count {
                guard let name = jsonDict[x]["name"] as? String, let screenName = jsonDict[x]["screen_name"] as? String, let imageURL = jsonDict[x]["profile_image_url"] as? String else { return }
                
                guard let url = URL(string: imageURL) else { return }
                
                
                NetworkController.performRequestForURL(url: url, httpMethod: .Get) { (data, error) in
                    guard let data = data else { return }
                    DispatchQueue.main.async() {
                        let newAccount = TwitterAccount(name: name, screenName: screenName, verified: true, schedule: nil, profileImageData: data)
                        accountArray.append(newAccount)
                        completion(accountArray)
            }
            
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
            sender.followButton.setImage(#imageLiteral(resourceName: "followMan"), for: .normal)
        } else {
            followedAccounts.append(account)
            sender.followButton.setImage(#imageLiteral(resourceName: "blueFollowMan"), for: .normal)
        }
        
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
            TwitterSearchTableViewController.delegate?.accountArray += self.followedAccounts
        }
    }
    
    //TODO: Check and make sure the account hasnt already been followed
    
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
        cell.followButton.setImage(#imageLiteral(resourceName: "followMan"), for: .normal)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        let account = twitterAccounts[indexPath.row]
        cell.updateWithAccount(account: account)
        
        
        
        return cell
    }
    
    
    
    
}


protocol searchDelegate {
    var accountArray: [TwitterAccount] { get set }
}
