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
    @IBOutlet weak var editCell: UITableViewCell!
    @IBOutlet weak var daysRowLabel: UILabel!
    @IBOutlet weak var startRowLabel: UILabel!
    @IBOutlet weak var endRowLabel: UILabel!
    
    
    
    
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
        accountCollectionView.allowsSelection = false
        
        startCell.isUserInteractionEnabled = false
        startRowLabel.isEnabled = false
        startTimeLabel.isEnabled = false
        endLabelCell.isUserInteractionEnabled = false
        endRowLabel.isEnabled = false
        endTimeLabel.isEnabled = false
        
        
        
        
        
        
        
        
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
        
        
        self.repeating = !self.repeating
        daysCell.isUserInteractionEnabled = !daysCell.isUserInteractionEnabled
        daysLabel.isEnabled = !daysLabel.isEnabled
        daysImage.isHidden = !daysImage.isHidden
        daysRowLabel.isEnabled = !daysRowLabel.isEnabled
        startCell.isUserInteractionEnabled = !startCell.isUserInteractionEnabled
        startRowLabel.isEnabled = !startRowLabel.isEnabled
        startTimeLabel.isEnabled = !startTimeLabel.isEnabled
        endLabelCell.isUserInteractionEnabled = !endLabelCell.isUserInteractionEnabled
        endRowLabel.isEnabled = !endRowLabel.isEnabled
        endTimeLabel.isEnabled = !endTimeLabel.isEnabled

        
        
        
        
        
        //addAccountLabel.isEnabled = false
        //addAccountCell.isUserInteractionEnabled = false
        self.tableView.reloadData()
        
    }
    
    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        guard let text = titleTextField.text, text.characters.count > 0 else { return }
        if accountArray.count > 0 {
            if let schedule = schedule  {
                editSchedule(schedule: schedule)
            } else {
                addSchedule()
            }
            self.performSegue(withIdentifier: "unwindToScheduleTable", sender: self)
        }
        
        
        
        
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 2.0
        cell?.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func editButttonPressed(_ sender: AnyObject) {
        self.navigationController?.setToolbarHidden(false, animated: true)
        
        accountCollectionView.allowsMultipleSelection = true
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        self.navigationController?.setToolbarHidden(true, animated: true)
        guard let indexPaths = accountCollectionView.indexPathsForSelectedItems else { return }
        for indexPath in indexPaths {
            let cell = accountCollectionView.cellForItem(at: indexPath)
            cell?.isSelected = false
            cell?.layer.borderWidth = 0
            cell?.layer.borderColor = UIColor.clear.cgColor
            
        }
        accountCollectionView.allowsSelection = false
        
    }
    
        
    
    @IBAction func deleteCells(_ sender: AnyObject) {
        guard let indexPaths = accountCollectionView.indexPathsForSelectedItems else { return }
        
        for indexPath in indexPaths {
            let index = indexPath.row
            accountArray.remove(at: index)
            let cell = accountCollectionView.cellForItem(at: indexPath)
            cell?.isSelected = false
            
        }
        
        accountCollectionView.deleteItems(at: indexPaths)
        accountCollectionView.allowsSelection = false
        self.navigationController?.setToolbarHidden(true, animated: true)
        
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 4
        case 2:
            return 3
        default:
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = self.tableView.rowHeight
        
        switch (indexPath.section, indexPath.row) {
        case (1,1):
            height = self.startDatePickerVisable ? 150.0 : 0.0
        case (1, 3):
            height = self.endDatePickerVisable ? 150.0 : 0.0
        case (2, 1):
            height = 150.0
        default:
            return height
        }
        return height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (indexPath.section, indexPath.row) {
        case (1, 0):
            if self.startDatePickerVisable {
                self.hideDatePicker(picker: startDatePicker, start: true)
            } else {
                self.showDatePicker(picker: startDatePicker, start: true)
            }
        case (1, 2):
            if self.endDatePickerVisable {
                self.hideDatePicker(picker: endDatePicker, start: false)
            } else {
                self.showDatePicker(picker: endDatePicker, start: false)
            }
        default:
            break
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
        
        
        return formatter.string(from: date)
    }
    
    func setupDayLabel() {
        
        if dayArray.count > 0 {
            daysLabel.isHidden = false
            daysImage.isHidden = true
            
            var dayLabelText = ""
            
            //TODO: Make this a switch
            
            if dayArray.count == 2 && dayArray.contains(0) && dayArray.contains(6) {
                daysLabel.text = "Weekend"
            } else if dayArray.count == 5 && dayArray.contains(1) && dayArray.contains(2) && dayArray.contains(3) && dayArray.contains(4) && dayArray.contains(5) {
                daysLabel.text = "Weekdays"
            } else if dayArray.count == 7 && dayArray.contains(1) && dayArray.contains(2) && dayArray.contains(3) && dayArray.contains(4) && dayArray.contains(5) && dayArray.contains(6) && dayArray.contains(7) {
                daysLabel.text = "Every day"
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

