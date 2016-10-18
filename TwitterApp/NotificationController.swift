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
        guard let day = schedule.days?.firstObject as? Days else { return }
        let number = Int(day.day)
        followDateComponents.weekday = number + 1
        followDateComponents.hour = 0
        
        
        
        followDateComponents.timeZone = TimeZone(abbreviation: "MST")
        followTrigger = UNCalendarNotificationTrigger(dateMatching: followDateComponents, repeats: true)
        
        
        var unfollowDateComponents = DateComponents()
        unfollowDateComponents.weekday = number
        unfollowDateComponents.hour = 24
        
        unfollowDateComponents.timeZone = TimeZone(abbreviation: "MST")
        unfollowTrigger = UNCalendarNotificationTrigger(dateMatching: unfollowDateComponents, repeats: true)
        
        
        
    } else {
        let calendar = Calendar.current
        guard let startDate = schedule.startTime, let endDate = schedule.endTime else { return }
        
        let followComponents = calendar.dateComponents([.month, .day, .year, .hour, .minute], from: startDate)
        
        
        
        
        
        let unfollowComponents = calendar.dateComponents([.month, .day, .year, .hour, .minute], from: endDate)
        
        
        
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


