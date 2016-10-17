//
//  Friendship.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/17/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit
import UserNotifications



class FriendshipController: NSObject, TwitterProtocol, UNUserNotificationCenterDelegate {
    
    static let sharedController = FriendshipController()
    
    func followAccounts() {
        let swifter = Swifter(consumerKey: consumerKey, consumerSecret: consumerSecret, oauthToken: accessToken, oauthTokenSecret: tokenSecret)
        
        
        
            swifter.followUser(for: .screenName("nba"), follow: nil, success: { (_) in
                //
            }) { (_) in
                print("fail")
            }

        }
        
        
    
    
    func scheduleNotificationRequest(title: String, interval: TimeInterval) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "test"
        content.body = "\(title) followed"
        let interval = interval
        let trigger =  UNTimeIntervalNotificationTrigger.init(timeInterval: interval, repeats: false)
        let identifier = title
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        center.add(request, withCompletionHandler: nil)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("willPresent")
    }
    
}

