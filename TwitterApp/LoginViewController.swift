//
//  LoginViewController.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/18/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit
import SafariServices
import TwitterKit
import Answers



class LoginViewController: UIViewController {
    
    
    func navigateToScheduleScreen() {
        performSegue(withIdentifier: "toScheduleView", sender: self)
        
    }
    
    @IBAction func loginButtonPressed(_ sender: AnyObject) {
        loginTwitter {
            self.navigateToScheduleScreen()
        }
    }
    
    func loginTwitter(completion: (() -> Void)) {
        
        
        
        
        Twitter.sharedInstance().logIn { (session, error) in
           
            if session != nil {
                
                
                
                UserDefaults.standard.set(session?.userID, forKey: "userID")
                
                
                
                
            }
            
        }
        
        
        completion()
        
    }
    
    
    

    

}
