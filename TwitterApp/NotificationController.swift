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
    
    
   







func scheduleFollowNotificationRequest(schedule: Schedule) {
    guard let accountArray = schedule.twitterAccounts?.allObjects as? [TwitterAccount] else { return }
    var userNameArray: [String] = []
    for account in accountArray {
        guard let screenName = account.screenName else { print("no screenname")
            return }
        userNameArray.append(screenName)
    }
    guard let title = schedule.title else { return }
    let followContent = UNMutableNotificationContent()
    let unfollowContent = UNMutableNotificationContent()
    
    var followTrigger: UNCalendarNotificationTrigger?
    var unfollowTrigger: UNCalendarNotificationTrigger?
    
    
    
    
    
    if let days = schedule.days, days.count > 0 {
        var followDateComponents = DateComponents()
        followDateComponents.weekday = 1
        followDateComponents.hour = 0
        followTrigger = UNCalendarNotificationTrigger(dateMatching: followDateComponents, repeats: true)
        followContent.body = "\(title) followed"
        
        var unfollowDateComponents = DateComponents()
        unfollowDateComponents.weekday = 1
        unfollowDateComponents.hour = 24
        unfollowTrigger = UNCalendarNotificationTrigger(dateMatching: unfollowDateComponents, repeats: true)
        unfollowContent.body = "\(title) unfollow"
        
        
    } else {
        print("no days")
    }
    
    //let follow = UNNotificationAction(identifier: "follow", title: "follow", options: [])
    let followCategory = UNNotificationCategory(identifier: "follow", actions: [], intentIdentifiers: [], options: [])
    let unfollowCategory = UNNotificationCategory(identifier: "unfollow", actions: [], intentIdentifiers: [], options: [])
    
    let center = UNUserNotificationCenter.current()
    center.setNotificationCategories([followCategory, unfollowCategory])
    
    
    
    followContent.categoryIdentifier = "follow"
    unfollowContent.categoryIdentifier = "unfollow"
    
    followContent.userInfo = ["userNames" : userNameArray]
    unfollowContent.userInfo = ["userNames" : userNameArray]
    
    
    
    let identifier = title
    
    let followRequest = UNNotificationRequest(identifier: identifier, content: followContent, trigger: followTrigger)
    let unfollowRequest = UNNotificationRequest(identifier: identifier, content: unfollowContent, trigger: unfollowTrigger)
    
    center.add(followRequest, withCompletionHandler: nil)
    center.add(unfollowRequest, withCompletionHandler: nil)
   
    
    }
}


