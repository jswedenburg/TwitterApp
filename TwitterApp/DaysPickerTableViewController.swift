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
    
    static var delegate: datePickerDelegate?
    
    var dayArray: [Int16] = []
    

    @IBAction func exitButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true) { 
            DaysPickerTableViewController.delegate?.dayArray = self.dayArray
        }
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
        
        if dayArray.contains(Int16(indexPath.row)) {
                cell.updateWithRow(row: indexPath.row, included: true)
            } else {
                cell.updateWithRow(row: indexPath.row, included: false)
            }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DayTableViewCell else { return }
        switch indexPath.row {
            case indexPath.row:
                
                if cell.checkMarkImage.isHidden {
                    
                    dayArray.append(Int16(indexPath.row))
                } else {
                    guard let index = dayArray.index(of: Int16(indexPath.row)) else { return }
                    dayArray.remove(at: index)
                }
            default:
                print("mistake")
            }
        
        cell.checkMarkImage.isHidden = !cell.checkMarkImage.isHidden
        tableView.reloadData()
        
    }

   
 

}


protocol datePickerDelegate {
    var dayArray: [Int16] { get set }
}
