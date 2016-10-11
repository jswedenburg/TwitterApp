//
//  DetailTableViewController.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/7/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit

class ScheduleDetailTableViewController: UITableViewController, datePickerDelegate {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var repeatingSwitch: UISwitch!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var daysImage: UIImageView!
    @IBOutlet weak var daysCell: UITableViewCell!
    
    var schedule: Schedule?
    var startDatePickerVisable: Bool = false
    var endDatePickerVisable: Bool = false
    
    var dayArray: [Int16] = [] {
        didSet {
            print("day array set: \(dayArray)")
        }
    }
    
    override func viewDidLoad() {
        DaysPickerTableViewController.delegate = self
        self.setDayArray()
    }
    
    
    @IBAction func repeatSwitchPressed(_ sender: AnyObject) {
        
        if repeatingSwitch.isOn {
            startDatePicker.datePickerMode = .time
            endDatePicker.datePickerMode = .time
            daysCell.isHidden = false
            self.tableView.reloadData()
        } else {
            startDatePicker.datePickerMode = .dateAndTime
            endDatePicker.datePickerMode = .dateAndTime
            daysCell.isHidden = true
            self.tableView.reloadData()
            
        }
        
    }
    
    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupView()
        //print(dayIntArray)
       // print(" Here is the days from core data: \(self.schedule?.days)")
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 7
        case 1:
            return 0
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = self.tableView.rowHeight
        if daysCell.isHidden {
            if indexPath.row == 1 {
                return 0.0
            }
        }
        
        if indexPath.row == 3 {
            height = self.startDatePickerVisable ? 100.0 : 0.0
        }
        
        if indexPath.row == 5 {
            height = self.endDatePickerVisable ? 100.0 : 0.0
        }
        return height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            if self.startDatePickerVisable {
                self.hideDatePicker(picker: startDatePicker, start: true)
            } else {
                self.showDatePicker(picker: startDatePicker, start: true)
            }
        }
        
        if indexPath.row == 4 {
            if self.endDatePickerVisable {
                self.hideDatePicker(picker: endDatePicker, start: false)
            } else {
                self.showDatePicker(picker: endDatePicker, start: false)
            }
        }
    }
    
    
    
    
    
    
    
    //MARK: Helper Functions
    
    func showDatePicker(picker: UIDatePicker, start: Bool){
        if start{
            self.startDatePickerVisable = true
        } else {
            self.endDatePickerVisable = true
        }
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        picker.isHidden = false
        picker.alpha = 0.0
        UIView.animate(withDuration: 0.25) {
            picker.alpha = 1.0
        }
    }
    
    func hideDatePicker(picker: UIDatePicker, start: Bool){
        if start{
            self.startDatePickerVisable = false
        } else {
            self.endDatePickerVisable = false
        }
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        UIView.animate(withDuration: 0.25, animations: {
            picker.alpha = 0.0
        }) { (_) in
            picker.isHidden = true
        }
    }
    
    func setupView(){
        startDatePicker.datePickerMode = .time
        endDatePicker.datePickerMode = .time
        
        if let schedule = schedule{
            setupDayLabel()
            titleTextField.text = schedule.title
            repeatingSwitch.isOn = schedule.repeating
            startTimeLabel.text = schedule.startTime?.description
            endTimeLabel.text = schedule.endTime?.description
            daysImage.isHidden = true
        } else {
            repeatingSwitch.isOn = true
            daysImage.image = #imageLiteral(resourceName: "calendar")
            daysLabel.isHidden = true
            startTimeLabel.text = "Select Start Time"
            endTimeLabel.text = "Select End Time"
            
            
        }
    }
    
    func setupDayLabel() {
        
        var dayLabelText = ""
        guard let schedule = schedule,
            let days = schedule.days else { return }
        var dayIntArray: [Int16] = []
        var count = days.count - 1
        
        if days.count > 0 {
            for x in 0...count {
                let day = days.object(at: x) as! Days
                dayIntArray.append(day.day)
                
                switch day.day {
                case 0:
                    dayLabelText += "Sunday, "
                case 1:
                    dayLabelText += "Monday, "
                case 2:
                    dayLabelText += "Tuesday, "
                case 3:
                    dayLabelText += "Wednesday, "
                case 4:
                    dayLabelText += "Thursday, "
                case 5:
                    dayLabelText += "Friday, "
                case 6:
                    dayLabelText += "Saturday, "
                default:
                    print("Other day")
                }
                
            }
            
        }
        
        daysLabel.text = dayLabelText
        
    }
    
    func setDayArray() {
        guard let schedule = schedule,
            let days = schedule.days else { return }
        var dayIntArray: [Int16] = []
        let count = days.count - 1
        
        if days.count > 0 {
            for x in 0...count {
                let day = days.object(at: x) as! Days
                dayIntArray.append(day.day)
            }
        }
        
        self.dayArray = dayIntArray
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let daypickerVC = segue.destination as? DaysPickerTableViewController else { return }
        daypickerVC.dayArray = self.dayArray
    }
    
    
    
    //TODO: Function to take a int and turn it into a string label for the days
    
    //TODO: Date helper function
    
    
    
}

