//
//  NotificationController.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/17/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationController: NSObject, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    static let sharedController = NotificationController()
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        guard let userNameArray = userInfo["userNames"] as? [String] else { return }
        if response.notification.request.content.categoryIdentifier == "follow" {
            let alert = UIAlertController(title: "Follow Accounts", message: "Test", preferredStyle: .alert)
            let action = UIAlertAction(title: "Follow", style: .default) { (_) in
                FriendshipController.sharedController.followAccounts(userNames: userNameArray)
            }
            alert.addAction(action)
            window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
        
    }
    
   
    
    
    
    func scheduleNotificationRequest(schedule: Schedule) {
        guard let accountArray = schedule.twitterAccounts?.allObjects as? [TwitterAccount] else { return }
        let userNameArray = accountArray.flatMap({$0.screenName})
        guard let title = schedule.title else { return }
        
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
            UNUserNotificationCenter.current().delegate = self
            if error != nil {
                print(error?.localizedDescription)
                
   
            }
        }
    }
}


