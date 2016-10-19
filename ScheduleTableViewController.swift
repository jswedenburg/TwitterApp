 //
//  ScheduleTableViewController.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/6/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit


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
    
   
    
    override func viewDidLoad() {
        self.tableView.reloadData()
        
    }
    
    
    
    
    func cellButtonPressed(sender: UITableViewCell) {
        guard let cell = sender as? ScheduleTableViewCell else { return }
        guard let sender = sender as? ScheduleTableViewCell else { return }
        guard let index = self.tableView.indexPath(for: sender)?.row else { return }
        let schedule = scheduleArray[index]
        let accounts = schedule.twitterAccounts?.allObjects as? [TwitterAccount] ?? []
        
        if schedule.enabled {
            FriendshipController.sharedController.unfollowAccounts(accounts: accounts)
            schedule.enabled = false
            cell.followButton.setImage(#imageLiteral(resourceName: "followMan"), for: .normal)
        } else {
            FriendshipController.sharedController.followAccounts(accounts: accounts)
            cell.followButton.setImage(#imageLiteral(resourceName: "blueFollowMan"), for: .normal)
            schedule.enabled = true
        }
        
        ScheduleController.sharedController.saveToPersistentStorage()
        
    }
    
    
    
    
    @IBAction func unwindToScheduleTable(segue: UIStoryboardSegue){
        if segue.source.isKind(of: ScheduleDetailTableViewController.self){
            guard let detailVC = segue.source as? ScheduleDetailTableViewController else { return }
            
            accountArray = detailVC.accountArray
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as? ScheduleTableViewCell else { return UITableViewCell() }
        let schedule = scheduleArray[indexPath.row]
        let accountArray2 = schedule.twitterAccounts?.allObjects as! [TwitterAccount]
        cell.updateWithSchedule(schedule: schedule, accounts: accountArray2)
        if schedule.enabled {
            cell.followButton.setImage(#imageLiteral(resourceName: "blueFollowMan"), for: .normal)
        } else {
            cell.followButton.setImage(#imageLiteral(resourceName: "followMan"), for: .normal)
        }
        cell.delegate = self
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let schedule = scheduleArray[indexPath.row]
            ScheduleController.sharedController.delete(schedule)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    //MARK: Helper Functions
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? ScheduleDetailTableViewController, let index = tableView.indexPathForSelectedRow?.row else {return}
        if segue.identifier == "editSchedule"{
                detailVC.schedule = scheduleArray[index]
            }
    
    }
}
