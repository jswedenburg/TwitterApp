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
    
    var days: [daysOfWeek] = [] {
        didSet {
            print(days)
        }
    }

    @IBAction func exitButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell") as? DayTableViewCell else { return UITableViewCell() }
        cell.updateWithRow(row: indexPath.row)
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DayTableViewCell else { return }
        if cell.dayIncluded{
            switch indexPath.row {
            case 0:
                guard let index = days.index(of: daysOfWeek.Sunday) else { return }
                days.remove(at: index)
            case 1:
                guard let index = days.index(of: daysOfWeek.Monday) else { return }
                days.remove(at: index)
            case 2:
                guard let index = days.index(of: daysOfWeek.Tuesday) else { return }
                days.remove(at: index)
            case 3:
                guard let index = days.index(of: daysOfWeek.Wednesay) else { return }
                days.remove(at: index)
            case 4:
                guard let index = days.index(of: daysOfWeek.Thursday) else { return }
                days.remove(at: index)
            case 5:
                guard let index = days.index(of: daysOfWeek.Friday) else { return }
                days.remove(at: index)
            case 6:
                guard let index = days.index(of: daysOfWeek.Saturday) else { return }
                days.remove(at: index)
            default:
                print("mistake")
            }
        } else {
            switch indexPath.row {
            case 0:
                days.append(daysOfWeek.Sunday)
            case 1:
                days.append(daysOfWeek.Monday)
            case 2:
                days.append(daysOfWeek.Tuesday)
            case 3:
                days.append(daysOfWeek.Wednesay)
            case 4:
                days.append(daysOfWeek.Thursday)
            case 5:
                days.append(daysOfWeek.Friday)
            case 6:
                days.append(daysOfWeek.Saturday)
            default:
                print("mistake")
            }
        }
        cell.dayIncluded = !cell.dayIncluded
        cell.checkMarkImage.isHidden = !cell.checkMarkImage.isHidden
        tableView.reloadData()
        
    }

   
 

}
