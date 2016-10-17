//
//  NotificationController.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/17/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationController: NSObject {
    
    var window: UIWindow?
    
    static let sharedController = NotificationController()
    
    
    
    
   
    
    
    
    func scheduleNotificationRequest(schedule: Schedule) {
        guard let accountArray = schedule.twitterAccounts?.allObjects as? [TwitterAccount] else { return }
        var userNameArray: [String] = []
        for account in accountArray {
            guard let screenName = account.screenName else { print("no screenname")
                return }
            userNameArray.append(screenName)
        }
        guard let title = schedule.title else { return }
        
        
        if let days = schedule.days, days.count > 0 {
            var dateComponents = DateComponents()
            dateComponents.weekday = 1
            dateComponents.weekday = 2
            let trigger = UNCalendarNotificationTrigger
        } else {
            print("no days")
        }
        
        //let follow = UNNotificationAction(identifier: "follow", title: "follow", options: [])
        let category = UNNotificationCategory(identifier: "follow", actions: [], intentIdentifiers: [], options: [])
        
        let center = UNUserNotificationCenter.current()
        center.setNotificationCategories([category])
        let content = UNMutableNotificationContent()
        content.title = "test"
        content.body = "\(title) followed"
        content.categoryIdentifier = "follow"
        
        content.userInfo = ["userNames" : userNameArray]
        
        let interval = 5.0
        let trigger =  UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        let identifier = title
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        
        center.add(request) { (error) in
            
            if error != nil {
                print(error?.localizedDescription)
                
   
            }
        }
    }
}


