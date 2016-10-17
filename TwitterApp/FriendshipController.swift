//
//  Friendship.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/17/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit
import UserNotifications



class FriendshipController: NSObject, TwitterProtocol {
    
    static let sharedController = FriendshipController()
    
    
    
    func followAccounts(userNames: [String]) {
        let swifter = Swifter(consumerKey: consumerKey, consumerSecret: consumerSecret, oauthToken: accessToken, oauthTokenSecret: tokenSecret)
        
        
        for userName in userNames {
            //guard let screenName = account.screenName else { return }
            swifter.followUser(for: .screenName(userName), follow: nil, success: { (_) in
                //
            }) { (_) in
                print("fail")
            }
            }
        

        }
    
   
        
        
    
    
   
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("did present")
        completionHandler([.badge,.alert,.sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        completionHandler()
    }
    
}

