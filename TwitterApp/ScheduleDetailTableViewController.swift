//
//  DetailTableViewController.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/7/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit

class ScheduleDetailTableViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource,  searchDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var accountCollectionView: UICollectionView!
    @IBOutlet weak var addAccountCell: UITableViewCell!
    @IBOutlet weak var addAccountLabel: UILabel!
    @IBOutlet weak var editCell: UITableViewCell!
   
    
    
    
    
    var schedule: Schedule?
    
   
    
    
    
    
    
    var accountArray: [TwitterAccount] = []
    
    override func viewDidLoad() {
       
        TwitterSearchTableViewController.delegate = self
        titleTextField.delegate = self
        self.navigationController?.setToolbarHidden(true, animated: true)
        setUpAccountArray()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tableView.reloadData()
        
    }
    
    //MARK: Text Field Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
    
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        
    }
    
    func addSchedule() {
        guard let scheduleTitle = titleTextField.text else { return }
        
        
        
        let newSchedule = Schedule(title: scheduleTitle)
        
        
        
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
        
        guard let scheduleTitle = titleTextField.text else { print("title?")
            return }
        schedule.title = scheduleTitle
        
        schedule.twitterAccounts = []
        
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
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = self.tableView.rowHeight
        
        switch indexPath.row {
        case 1:
            height = 150.0
        default:
            return height
        }
        return height
    }
    
    //MARK: Helper Functions
    
    
    
    func setupView(){
        
        if let schedule = schedule{
            titleTextField.text = schedule.title
        } else {
            
            titleTextField.placeholder = "Title"
        }
    }
    
    
    
    func setUpAccountArray(){
        if let schedule = schedule, let accounts = schedule.twitterAccounts?.allObjects as? [TwitterAccount] {
            self.accountArray = accounts
        }
    }
    
    
    
    
    
      
    
    
}

