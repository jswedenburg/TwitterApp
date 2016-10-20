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
        Twitter.sharedInstance().logIn { (session, error) in
            if session != nil {
            
               
                self.navigateToScheduleScreen()
                UserDefaults.standard.set(session?.userID, forKey: "userID")
                
                
               Answers.logLogin(withMethod: "Twitter", success: true, customAttributes: ["User ID": session!.userID])
                
            }
        }
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
