 //
 //  ScheduleTableViewController.swift
 //  TwitterApp
 //
 //  Created by Jake SWEDENBURG on 10/6/16.
 //  Copyright © 2016 Jake Swedenbug. All rights reserved.
 //
 
 import UIKit
 import TwitterKit
 
 
 class ScheduleTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TableViewCellDelegate, UINavigationControllerDelegate {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //Properties
    let twitterBlue = UIColor(red: 29/255, green: 161/255, blue: 242/155, alpha: 1.0)
    var scheduleArray: [Schedule] {
        return ScheduleController.sharedController.schedules
    }
    var accountArray: [TwitterAccount] = [] {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    //MARK: View Overriding Methods
    override func viewDidLoad() {
        self.tableView.reloadData()
        self.navigationController?.navigationBar.barStyle = .black
        if let titleFont = UIFont(name: "PaulGrotesk-Bold-Trail", size: 25) {
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: titleFont]
        }
        self.navigationController?.navigationBar.barTintColor = twitterBlue
     }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        self.tableView.reloadData()
    }
    
    //MARK: Actions
    @IBAction func logoutButtonPressed(_ sender: AnyObject) {
        logOut()
    }
    
    @IBAction func unwindToScheduleTable(segue: UIStoryboardSegue){
        if segue.source.isKind(of: ScheduleDetailViewController.self){
            guard let detailVC = segue.source as? ScheduleDetailViewController else { return }
            accountArray = detailVC.accountArray
        }
    }
    
    //MARK: Helper Functions
    func logOut() {
        let sessionStore = Twitter.sharedInstance().sessionStore
        if let userID = sessionStore.session()?.userID {
            sessionStore.logOutUserID(userID)
        }
        UserDefaults.standard.removeObject(forKey: "userID")
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let loginVC = storyBoard.instantiateViewController(withIdentifier: "loginVC") as? LoginViewController else { return }
        present(loginVC, animated: true, completion: nil)
    }
    
    //MARK: TableViewCellDelegate
    func cellButtonPressed(sender: UITableViewCell) {
        guard let cell = sender as? ScheduleTableViewCell else { return }
        guard let sender = sender as? ScheduleTableViewCell else { return }
        guard let index = self.tableView.indexPath(for: sender)?.section else { return }
        cell.followButton.isEnabled = false
        let schedule = scheduleArray[index - 1]
        let accounts = schedule.twitterAccounts?.allObjects as? [TwitterAccount] ?? []
        if schedule.enabled {
            cell.followButton.setImage(#imageLiteral(resourceName: "borderbird"), for: .normal)
            FriendshipController.sharedController.unfollowAccounts(accounts: accounts, completion: { (error) in
                if error == true {
                    let alertController = UIAlertController(title: "Unfollowing Failed", message: "Please attempt at a later time", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                        cell.followButton.setImage(#imageLiteral(resourceName: "bluebird"), for: .normal)
                        self.logOut()
                    })
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    schedule.enabled = false
                }
            })
        } else {
            cell.followButton.setImage(#imageLiteral(resourceName: "bluebird"), for: .normal)
            FriendshipController.sharedController.followAccounts(accounts: accounts, completion: { (error) in
                if error == true {
                    let alertController = UIAlertController(title: "Following Failed", message: "Please attempt at a later time", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                        cell.followButton.setImage(#imageLiteral(resourceName: "borderbird"), for: .normal)
                        self.logOut()
                    })
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    schedule.enabled = true
                }
            })
        }
        ScheduleController.sharedController.saveToPersistentStorage()
        cell.followButton.isEnabled = true
    }
    
    
    //MARK: Tableview Datasource and Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return scheduleArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let titleCell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as? TitleTableViewCell else { return UITableViewCell()}
            titleCell.titleLabel.text = "Groups"
            titleCell.isUserInteractionEnabled = false
            return titleCell
        } else {
            guard let scheduleCell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as? ScheduleTableViewCell else { return UITableViewCell() }
            let schedule = scheduleArray[indexPath.section - 1]
            let accountArray2 = schedule.twitterAccounts?.allObjects as! [TwitterAccount]
            scheduleCell.updateWithSchedule(schedule: schedule, accounts: accountArray2)
            
            if schedule.enabled {
                scheduleCell.followButton.setImage(#imageLiteral(resourceName: "bluebird"), for: .normal)
            } else {
                scheduleCell.followButton.setImage(#imageLiteral(resourceName: "borderbird"), for: .normal)
            }
            scheduleCell.delegate = self
            scheduleCell.backgroundColor = UIColor.white
            scheduleCell.contentView.layer.borderColor = UIColor(red: 170/255, green: 184/255, blue: 194/255, alpha: 1.0).cgColor
            scheduleCell.contentView.layer.borderWidth = 0.2
            scheduleCell.contentView.layer.cornerRadius = 10
            scheduleCell.layer.cornerRadius = 10
            return scheduleCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0  {
            return 63
        } else if indexPath.section == 1{
            return 90
        }else {
            return 90
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let schedule = scheduleArray[indexPath.section - 1]
            ScheduleController.sharedController.delete(schedule)
            let indexSet = NSMutableIndexSet()
            indexSet.add(indexPath.section)
            self.tableView.deleteSections(indexSet as IndexSet, with: .bottom)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 20
        }
        return 1.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 20
        }
        return 5.0
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navVC = segue.destination as? UINavigationController, let detailVC = navVC.topViewController as? ScheduleDetailViewController, let index = tableView.indexPathForSelectedRow?.section else {return}
        if segue.identifier == "editSchedule"{
            detailVC.schedule = scheduleArray[index - 1]
        }
    }
 }
