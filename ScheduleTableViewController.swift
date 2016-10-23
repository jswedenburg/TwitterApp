 //
//  ScheduleTableViewController.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/6/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit
 import TwitterKit


class ScheduleTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TableViewCellDelegate {
    
    
   
    
    
    var scheduleArray: [Schedule] {
        return ScheduleController.sharedController.schedules
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var accountArray: [TwitterAccount] = [] {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
    }
    
   
        
        
        
        
    
    
   
    
    
    
    
    @IBAction func logoutButtonPressed(_ sender: AnyObject) {
        logOut()
    }
    
    func logOut() {
        let sessionStore = Twitter.sharedInstance().sessionStore
        if let userID = sessionStore.session()?.userID {
            sessionStore.logOutUserID(userID)
        }
        //UserDefaults.standard.removeObject(forKey: "userID")
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let loginVC = storyBoard.instantiateViewController(withIdentifier: "loginVC") as? LoginViewController else { return }
        
        present(loginVC, animated: true, completion: nil)
    }
    
    
    func cellButtonPressed(sender: UITableViewCell) {
        
        guard let cell = sender as? ScheduleTableViewCell else { return }
        cell.followButton.isEnabled = false
        guard let sender = sender as? ScheduleTableViewCell else { return }
        guard let index = self.tableView.indexPath(for: sender)?.row else { return }
        let schedule = scheduleArray[index - 1]
        let accounts = schedule.twitterAccounts?.allObjects as? [TwitterAccount] ?? []
        
        if schedule.enabled {
            FriendshipController.sharedController.unfollowAccounts(accounts: accounts, completion: { (error) in
                if error == true {
                    let alertController = UIAlertController(title: "Unfollowing Failed", message: "Please attempt at a later time", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                        self.logOut()
                    })
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    cell.followButton.setImage(#imageLiteral(resourceName: "borderbird"), for: .normal)
                    schedule.enabled = false
                }
            })
        } else {
            
            FriendshipController.sharedController.followAccounts(accounts: accounts, completion: { (error) in
                if error == true {
                    let alertController = UIAlertController(title: "Following Failed", message: "Please attempt at a later time", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                        self.logOut()
                    })
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    cell.followButton.setImage(#imageLiteral(resourceName: "bluebird"), for: .normal)
                    schedule.enabled = true
                }
                
            })
            
        }
        
        ScheduleController.sharedController.saveToPersistentStorage()
        cell.followButton.isEnabled = true
        
    }
    
    
    
    
    @IBAction func unwindToScheduleTable(segue: UIStoryboardSegue){
        if segue.source.isKind(of: ScheduleDetailViewController.self){
            guard let detailVC = segue.source as? ScheduleDetailViewController else { return }
            
            accountArray = detailVC.accountArray
            
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return scheduleArray.count + 1

        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let titleCell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as? TitleTableViewCell else { return UITableViewCell()}
            titleCell.titleLabel.text = "Groups"
            titleCell.isUserInteractionEnabled = false
            
            //titleCell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 300)
            //self.tableView.separatorStyle = .singleLine
            
            return titleCell
        } else {
            guard let scheduleCell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as? ScheduleTableViewCell else { return UITableViewCell() }
            let schedule = scheduleArray[indexPath.row - 1]
            let accountArray2 = schedule.twitterAccounts?.allObjects as! [TwitterAccount]
            scheduleCell.updateWithSchedule(schedule: schedule, accounts: accountArray2)
            if schedule.enabled {
                scheduleCell.followButton.setImage(#imageLiteral(resourceName: "bluebird"), for: .normal)
            } else {
                scheduleCell.followButton.setImage(#imageLiteral(resourceName: "borderbird"), for: .normal)
            }
            scheduleCell.delegate = self
            scheduleCell.backgroundColor = UIColor.white
            
            //scheduleCell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
            
            
            
            return scheduleCell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0  {
            return 100
        } else if indexPath.row == 1{
            return 90
        }else {
            return 90
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            cell.contentView.backgroundColor = UIColor.clear
            
            let whiteRoundedView : UIView = UIView(frame: CGRect(x: 0, y: 3, width: self.view.frame.size.width, height: self.view.frame.size.height))
            
            whiteRoundedView.layer.backgroundColor = UIColor.white.cgColor
            whiteRoundedView.layer.masksToBounds = false
            whiteRoundedView.layer.cornerRadius = 2.0
            
            whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: -10)
            whiteRoundedView.layer.shadowOpacity = 0.2
            whiteRoundedView.layer.shadowColor = UIColor(red: 170/255, green: 184/255, blue: 194/255, alpha: 1).cgColor
            
            cell.contentView.addSubview(whiteRoundedView)
            cell.contentView.sendSubview(toBack: whiteRoundedView)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let schedule = scheduleArray[indexPath.row - 1]
            ScheduleController.sharedController.delete(schedule)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    
    
    //MARK: Helper Functions
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navVC = segue.destination as? UINavigationController, let detailVC = navVC.topViewController as? ScheduleDetailViewController, let index = tableView.indexPathForSelectedRow?.row else {return}
        
        if segue.identifier == "editSchedule"{
                detailVC.schedule = scheduleArray[index - 1]
            }
    
    }
}
