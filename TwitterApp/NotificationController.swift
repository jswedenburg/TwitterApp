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
    followContent.body = "\(title) followed"
    unfollowContent.body = "\(title) unfollow"
    
    
    //WHY is days never nil?
    if schedule.days!.count > 0 {
        var followDateComponents = DateComponents()
        followDateComponents.weekday = 1
        
        
        followDateComponents.timeZone = TimeZone(abbreviation: "MST")
        followTrigger = UNCalendarNotificationTrigger(dateMatching: followDateComponents, repeats: true)
        
        
        var unfollowDateComponents = DateComponents()
        unfollowDateComponents.weekday = 1
        
        unfollowDateComponents.timeZone = TimeZone(abbreviation: "MST")
        unfollowTrigger = UNCalendarNotificationTrigger(dateMatching: unfollowDateComponents, repeats: true)
        
        
        
    } else {
        let calendar = NSCalendar.current
        guard let startDate = schedule.startTime, let endDate = schedule.endTime else { return }
        var followComponents = calendar.dateComponents([.month, .day], from: startDate)
        followComponents.hour = 0
        followComponents.timeZone = TimeZone(abbreviation: "MST")
        var unfollowComponents = calendar.dateComponents([.month, .day], from: endDate)
        unfollowComponents.hour = 23
        unfollowComponents.timeZone = TimeZone(abbreviation: "MST")
        
        followTrigger = UNCalendarNotificationTrigger(dateMatching: followComponents, repeats: false)
        unfollowTrigger = UNCalendarNotificationTrigger(dateMatching: unfollowComponents, repeats: false)

    }
    
    //let follow = UNNotificationAction(identifier: "follow", title: "follow", options: [])
    let followCategory = UNNotificationCategory(identifier: "\(title)follow", actions: [], intentIdentifiers: [], options: [])
    let unfollowCategory = UNNotificationCategory(identifier: "\(title)unfollow", actions: [], intentIdentifiers: [], options: [])
    
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


