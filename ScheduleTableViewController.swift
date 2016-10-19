 //
//  ScheduleTableViewController.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/6/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit


class ScheduleTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TableViewCellDelegate {
    
    var following: Bool = true
    
    var scheduleArray: [Schedule] {
        return ScheduleController.sharedController.schedules
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var dayLabelText: String = ""
    var accountArray: [TwitterAccount] = [] {
        didSet{
            self.tableView.reloadData()
        }
    }
    
   
    
    override func viewDidLoad() {
        self.tableView.reloadData()
        
    }
    
    
    
    
    func cellButtonPressed(sender: UITableViewCell) {
        if following{
            self.following = false
        } else {
            guard let sender = sender as? ScheduleTableViewCell else { return }
            guard let index = self.tableView.indexPath(for: sender)?.row else { return }
            let schedule = scheduleArray[index]
            let accounts = schedule.twitterAccounts?.allObjects as? [TwitterAccount] ?? []
            FriendshipController.sharedController.followAccounts(accounts: accounts)
            self.following = true
        }
    }
    
    
    
    
    @IBAction func unwindToScheduleTable(segue: UIStoryboardSegue){
        if segue.source.isKind(of: ScheduleDetailTableViewController.self){
            guard let detailVC = segue.source as? ScheduleDetailTableViewController else { return }
            guard let text = detailVC.daysLabel.text else { return }
            accountArray = detailVC.accountArray
            self.dayLabelText = text
            print(dayLabelText)
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as? ScheduleTableViewCell else { return UITableViewCell() }
        let schedule = scheduleArray[indexPath.row]
        let accountArray2 = schedule.twitterAccounts?.allObjects as! [TwitterAccount]
        cell.updateWithSchedule(schedule: schedule, dayLabelText: self.dayLabelText, accounts: accountArray2)
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
