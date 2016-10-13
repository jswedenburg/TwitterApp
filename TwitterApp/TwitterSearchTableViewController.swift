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
    var delegate: TableViewCellDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        NetworkController.twitterSearch(searchTerm: "nfl") { (accounts) in
            self.twitterAccounts = accounts
        }
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var followedAccounts: [TwitterAccount] = [] {
        didSet{
            print(followedAccounts)
        }
    }
    
    
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
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
