//
//  DetailTableViewController.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/7/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit

class ScheduleDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,  searchDelegate, UITextFieldDelegate {
    
    
    //MARK: Outlets
    @IBOutlet weak var accountCollectionView: UICollectionView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    
    //MARK: Properties
    
    let twitterBlue = UIColor(red: CGFloat(29.0/255.0), green: CGFloat(161.0/255.0), blue: CGFloat(242.0/255.0), alpha: 1.0)
    var editingMode: Bool = false
    var schedule: Schedule?
    var accountArray: [TwitterAccount] = []
    
    //MARK: View Cycle Overriding Methods
    override func viewDidLoad() {
        TwitterSearchTableViewController.delegate = self
        titleTextField.delegate = self
        self.navigationController?.setToolbarHidden(true, animated: true)
        setUpAccountArray()
        setupView()
        setUpFlow()
        self.accountCollectionView.allowsSelection = false
        self.toolBar.isHidden = true
        self.navigationController?.navigationBar.barTintColor = twitterBlue
        if let titleFont = UIFont(name: "PaulGrotesk-Bold-Trail", size: 25) {
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: titleFont]
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupView()
        self.accountCollectionView.reloadData()
    }
    
    //MARK: Helper Methods
    func setUpFlow() {
        let flow = UICollectionViewFlowLayout()
        let width = self.view.frame.width / 3
        let height = self.view.frame.height / 5
        flow.itemSize = CGSize(width: width - 3, height: height + 4)
        flow.minimumLineSpacing = 1
        flow.minimumInteritemSpacing = 1
        flow.sectionInset = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
        self.accountCollectionView.collectionViewLayout = flow
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
        guard let scheduleTitle = titleTextField.text else { return }
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
    
    func setupView(){
        if let schedule = schedule{
            titleTextField.text = schedule.title
        } else {
            titleTextField.placeholder = "title"
        }
    }
    
    func setUpAccountArray(){
        if let schedule = schedule, let accounts = schedule.twitterAccounts?.allObjects as? [TwitterAccount] {
            self.accountArray = accounts
        }
    }
    
    //MARK: Text Field Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: Actions
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
    
    @IBAction func cancelScheduleButtonPressed(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "unwindToScheduleTable", sender: self)
    }
    
    @IBAction func editButttonPressed(_ sender: AnyObject) {
        self.editingMode = true
        self.accountCollectionView.reloadData()
        self.toolBar.isHidden = false
        self.toolBar.isTranslucent = true
        accountCollectionView.allowsMultipleSelection = true
        self.editButton.isEnabled = false
    }
    
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        self.toolBar.isHidden = true
        guard let indexPaths = accountCollectionView.indexPathsForSelectedItems else { return }
        for indexPath in indexPaths {
            guard let cell = self.accountCollectionView.cellForItem(at: indexPath) as? AccountCollectionViewCell else { return }
            cell.isSelected = false
            cell.layer.borderWidth = 0
            cell.checkMarkImageView.image = nil
        }
        accountCollectionView.allowsSelection = false
        self.editingMode = false
        self.accountCollectionView.reloadData()
        self.editButton.isEnabled = true
    }
    
    @IBAction func deleteCells(_ sender: AnyObject) {
        self.toolBar.isHidden = true
        guard let indexPaths = self.accountCollectionView.indexPathsForSelectedItems else { return }
        var accountsToDelete: [TwitterAccount] = []
        for indexPath in indexPaths {
            guard let cell = self.accountCollectionView.cellForItem(at: indexPath) as? AccountCollectionViewCell else { return }
            let index = indexPath.row
            accountsToDelete.append(accountArray[index])
            print(indexPath.row)
            cell.isSelected = false
            cell.layer.borderWidth = 0
            cell.checkMarkImageView.image = nil
        }
        if accountsToDelete.count > 0 {
            for account in accountsToDelete {
                if let index = accountArray.index(of: account) {
                    accountArray.remove(at: index)
                }
            }
        }
        self.accountCollectionView.performBatchUpdates({
            self.accountCollectionView.deleteItems(at: indexPaths)
        }) { (_) in
            self.accountCollectionView.reloadData()
        }
        accountCollectionView.allowsSelection = false
        self.editingMode = false
        self.editButton.isEnabled = true
     }
    
    //MARK: - Collection View Data Source and Delegate
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
        if editingMode {
            cell.checkMarkImageView.backgroundColor = UIColor.white
            cell.checkMarkImageView.isHidden = false
        } else {
            cell.checkMarkImageView.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? AccountCollectionViewCell else { return }
        cell.checkMarkImageView.image = #imageLiteral(resourceName: "checkmark-1")
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.red.cgColor
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? AccountCollectionViewCell else { return }
        cell.layer.borderWidth = 0
        cell.checkMarkImageView.image = nil
    }
}

