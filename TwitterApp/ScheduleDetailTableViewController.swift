//
//  DetailTableViewController.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/7/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit

class ScheduleDetailTableViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource, datePickerDelegate, searchDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var repeatingSwitch: UISwitch!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var daysImage: UIImageView!
    @IBOutlet weak var daysCell: UITableViewCell!
    @IBOutlet weak var accountCollectionView: UICollectionView!
    @IBOutlet weak var startCell: UITableViewCell!
    @IBOutlet weak var startPickerCell: UITableViewCell!
    @IBOutlet weak var endLabelCell: UITableViewCell!
    @IBOutlet weak var endPickerCell: UITableViewCell!
    @IBOutlet weak var repeatingCell: UITableViewCell!
    @IBOutlet weak var addAccountCell: UITableViewCell!
    @IBOutlet weak var addAccountLabel: UILabel!
    
    
    
    var schedule: Schedule?
    var startDatePickerVisable: Bool = false
    var endDatePickerVisable: Bool = false
    var repeating: Bool = true
    
    var dayArray: [Int16] = [] {
        didSet {
            setupDayLabel()
        }
    }
    
    var accountArray: [TwitterAccount] = []
    
    override func viewDidLoad() {
        DaysPickerTableViewController.delegate = self
        TwitterSearchTableViewController.delegate = self
        titleTextField.delegate = self
        self.navigationController?.setToolbarHidden(true, animated: true)
        self.setDayArray()
        setUpAccountArray()
        setupView()
        
        
        daysCell.isHidden = false
        startCell.isHidden = true
        startPickerCell.isHidden = true
        endLabelCell.isHidden = true
        endPickerCell.isHidden = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tableView.reloadData()
    }
    
    //MARK: Text Field Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func repeatSwitchPressed(_ sender: AnyObject) {
        
        
        daysCell.isHidden = !daysCell.isHidden
        startCell.isHidden = !startCell.isHidden
        startPickerCell.isHidden = !startPickerCell.isHidden
        endLabelCell.isHidden = !endLabelCell.isHidden
        endPickerCell.isHidden = !endPickerCell.isHidden
        self.repeating = !self.repeating
        self.tableView.reloadData()
        //addAccountLabel.isEnabled = false
        //addAccountCell.isUserInteractionEnabled = false
        
        
    }
    
    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        if let schedule = schedule {
            editSchedule(schedule: schedule)
        } else {
            addSchedule()
        }
        
        self.performSegue(withIdentifier: "unwindToScheduleTable", sender: self)
        
        //_ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    func addSchedule() {
        guard let scheduleTitle = titleTextField.text else { return }
        let scheduleStartTime = startDatePicker.date
        let scheduleEndTime = endDatePicker.date
        let scheduleRepeating = repeatingSwitch.isOn
        let newSchedule = Schedule(repeating: scheduleRepeating, startTime: scheduleStartTime, endTime: scheduleEndTime, title: scheduleTitle)
        
        for day in dayArray {
            
            let newDay = Days(day: day, schedule: newSchedule)
            DaysController.sharedController.add(newDay)
        }
        for account in accountArray {
            guard let name = account.name,
                let screenName = account.screenName,
                let imageData = account.profileImage else { return }
            let verified = account.verified
            let newAccount = TwitterAccount(name: name, screenName: screenName, verified: verified, schedule: newSchedule, profileImageData: imageData)
            TwitterAccountController.sharedController.add(newAccount)
        }
        
        
        ScheduleController.sharedController.saveToPersistentStorage()
        
    }
    
    func editSchedule(schedule: Schedule){
        schedule.title = titleTextField.text
        schedule.startTime = startDatePicker.date
        schedule.endTime = endDatePicker.date
        schedule.repeating = repeatingSwitch.isOn
        schedule.days = []
        schedule.twitterAccounts = []
        for day in dayArray {
            
            let newDay = Days(day: day, schedule: schedule)
            DaysController.sharedController.add(newDay)
        }
        for account in accountArray {
            guard let name = account.name,
                let screenName = account.screenName,
                let imageData = account.profileImage else { return }
            let verified = account.verified
            let newAccount = TwitterAccount(name: name, screenName: screenName, verified: verified, schedule: schedule, profileImageData: imageData)
            TwitterAccountController.sharedController.add(newAccount)
        }
        
        
        ScheduleController.sharedController.saveToPersistentStorage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupView()
        self.accountCollectionView.reloadData()
        
        
    }
    
    //MARK: - Collection View Data Source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return accountArray.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.accountCollectionView.dequeueReusableCell(withReuseIdentifier: "accountCell", for: indexPath) as? AccountCollectionViewCell else { return UICollectionViewCell()}
        let account = accountArray[indexPath.row]
        cell.updateWithAccount(account: account)
        return cell
    }
    @IBAction func editButttonPressed(_ sender: AnyObject) {
        self.navigationController?.setToolbarHidden(false, animated: true)
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        accountCollectionView.allowsMultipleSelection = editing
        
    }
    @IBAction func deleteCells(_ sender: AnyObject) {
        guard let indexPaths = accountCollectionView.indexPathsForSelectedItems else { return }
        
        for indexPath in indexPaths {
            let index = indexPath.row
            accountArray.remove(at: index)
            
        }
        
        accountCollectionView.deleteItems(at: indexPaths)
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
            return 2
        default:
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = self.tableView.rowHeight
        if repeating == false {
            if indexPath.row == 1 {
                return 0.0
            }
        }
        
        if repeating == true{
            if indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 {
                height = 0.0
                
            }
        }
        
        if indexPath.row == 3 {
            height = self.startDatePickerVisable ? 100.0 : 0.0
        }
        
        if indexPath.row == 5 {
            height = self.endDatePickerVisable ? 100.0 : 0.0
        }
        
        if indexPath.section == 1 && indexPath.row == 0 {
            height = 150
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
            if picker == self.startDatePicker {
                self.startTimeLabel.text = self.dateFormatter(date: picker.date)
            } else {
                self.endTimeLabel.text = self.dateFormatter(date: picker.date)
            }
            
        }
    }
    
    func setupView(){
        startDatePicker.datePickerMode = .date
        endDatePicker.datePickerMode = .date
        
        if let schedule = schedule{
            guard let startDate = schedule.startTime else { return }
            guard let endDate = schedule.endTime else { return }
            
            titleTextField.text = schedule.title
            repeatingSwitch.isOn = schedule.repeating
            endDatePicker.date = endDate
            startDatePicker.date = startDate
            startTimeLabel.text = dateFormatter(date: schedule.startTime!)
            endTimeLabel.text = dateFormatter(date: schedule.endTime!)
            
            daysImage.isHidden = true
        } else {
            
            daysImage.image = #imageLiteral(resourceName: "calendar")
            daysLabel.isHidden = true
            titleTextField.placeholder = "Title"
            
            startTimeLabel.text = "Select Start Time"
            endTimeLabel.text = "Select End Time"
            
            
        }
    }
    
    func dateFormatter(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter.string(from: date)
    }
    
    func setupDayLabel() {
        
        if dayArray.count > 0 {
            daysLabel.isHidden = false
            daysImage.isHidden = true
            
            var dayLabelText = ""
            
            if dayArray.count == 2 && dayArray.contains(0) && dayArray.contains(6) {
                daysLabel.text = "Weekend"
            } else if dayArray.count == 5 && dayArray.contains(1) && dayArray.contains(2) && dayArray.contains(3) && dayArray.contains(4) && dayArray.contains(5) {
                daysLabel.text = "Weekdays"
            } else {
                
                for day in dayArray {
                    
                    
                    switch day  {
                    case 0:
                        dayLabelText += "Sun "
                    case 1:
                        dayLabelText += "Mon "
                    case 2:
                        dayLabelText += "Tue "
                    case 3:
                        dayLabelText += "Wed "
                    case 4:
                        dayLabelText += "Thu "
                    case 5:
                        dayLabelText += "Fri "
                    case 6:
                        dayLabelText += "Sat "
                    default:
                        print("Other day")
                    }
                    
                    
                    
                }
            daysLabel.text = dayLabelText
                
            }
            
            
            
            
            
            
            
        }
        
        
        
        
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
    
    func setUpAccountArray(){
        if let schedule = schedule, let accounts = schedule.twitterAccounts?.allObjects as? [TwitterAccount] {
            self.accountArray = accounts
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let daypickerVC = segue.destination as? DaysPickerTableViewController else { return }
        daypickerVC.dayArray = self.dayArray
    }
    
    
    
    //TODO: Function to take a int and turn it into a string label for the days
    
    //TODO: Date helper function
    
    
    
}

