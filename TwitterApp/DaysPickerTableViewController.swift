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
        cell.updateWithRow(row: indexPath.row)
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DayTableViewCell else { return }
        guard let schedule = schedule else { return }
        if cell.dayIncluded == false{
            switch indexPath.row {
            case 0:
                let day = Days(day: 0, schedule: schedule)
                DaysController.sharedController.add(day)
            case 1:
                let day = Days(day: 1, schedule: schedule)
                DaysController.sharedController.add(day)
            case 2:
                let day = Days(day: 2, schedule: schedule)
                DaysController.sharedController.add(day)
            case 3:
                let day = Days(day: 3, schedule: schedule)
                DaysController.sharedController.add(day)
            case 4:
                let day = Days(day: 4, schedule: schedule)
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
        } else {
            switch indexPath.row {
            case 0:
                let day = Days(day: 0, schedule: schedule)
                DaysController.sharedController.delete(day)
            case 1:
                let day = Days(day: 1, schedule: schedule)
                DaysController.sharedController.delete(day)

            case 2:
                let day = Days(day: 2, schedule: schedule)
                DaysController.sharedController.delete(day)

            case 3:
                let day = Days(day: 3, schedule: schedule)
                DaysController.sharedController.delete(day)

            case 4:
                let day = Days(day: 4, schedule: schedule)
                DaysController.sharedController.delete(day)

            case 5:
                let day = Days(day: 5, schedule: schedule)
                DaysController.sharedController.delete(day)

            case 6:
                let day = Days(day: 6, schedule: schedule)
                DaysController.sharedController.delete(day)

            default:
                print("mistake")
            }
        }
        cell.dayIncluded = !cell.dayIncluded
        cell.checkMarkImage.isHidden = !cell.checkMarkImage.isHidden
        tableView.reloadData()
        
    }

   
 

}
