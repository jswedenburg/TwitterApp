//
//  DaysPickerTableViewController.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/10/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit

class DaysPickerTableViewController: UITableViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

           }
    
    var schedule: Schedule?
    
    var dayArray: [Int16] = []
    

    @IBAction func exitButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell") as? DayTableViewCell else { return UITableViewCell() }
        
        guard let schedule = schedule,
            let days = schedule.days else { return UITableViewCell() }
        var dayIntArray: [Int16] = []
        var count = days.count - 1
        if days.count > 0 {
            for x in 0...count {
                let day = days.object(at: x) as! Days
                dayIntArray.append(day.day)
                
            }
            
            if dayIntArray.contains(Int16(indexPath.row)) {
                cell.updateWithRow(row: indexPath.row, included: true)
            } else {
                cell.updateWithRow(row: indexPath.row, included: false)
            }
        }
        

        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DayTableViewCell else { return }
        guard let schedule = schedule, let days = schedule.days else { return }
        
        
        
            switch indexPath.row {
            case 0:
                let sunday = Days(day: 0, schedule: schedule)
                if cell.checkMarkImage.isHidden {
                    DaysController.sharedController.add(sunday)
                } else {
                    DaysController.sharedController.delete(sunday)
                    if let daysArray = days.array as? [Days] {
                        let matchingDay = daysArray.index { $0.day == 0 }
                        DaysController.sharedController.delete(matchingDay)
                    }
                }
            case 1:
                let monday = Days(day: 1, schedule: schedule)
                if cell.checkMarkImage.isHidden {
                    DaysController.sharedController.add(monday)
                } else {
                    DaysController.sharedController.delete(monday)
                }
            case 2:
                let day = Days(day: 2, schedule: schedule)
                DaysController.sharedController.add(day)
            case 3:
                let day = Days(day: 3, schedule: schedule)
                DaysController.sharedController.add(day)
            case 4:
                let day = Days(day: 3, schedule: schedule)
                DaysController.sharedController.add(day)
            case 5:
                let day = Days(day: 5, schedule: schedule)
                DaysController.sharedController.add(day)
            case 6:
                let day = Days(day: 6, schedule: schedule)
                DaysController.sharedController.add(day)
            default:
                print("mistake")
            }
        
        
        cell.checkMarkImage.isHidden = !cell.checkMarkImage.isHidden
        tableView.reloadData()
        
    }

   
 

}
