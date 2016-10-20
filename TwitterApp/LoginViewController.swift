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
    
    
    
    
    /*
    var loginSwifter: Swifter
    
    required init?(coder aDecoder: NSCoder) {
        
        self.loginSwifter = Swifter(consumerKey: "50rD7EZObZk07pIr2wOjT18DT" , consumerSecret: "t7wfSf8x4vXgD7s9UtyRFsfQnR8qAdlyddJbTpv4E1fhD7d2Qd")
        super.init(coder: aDecoder)
        
    }
    
    func login() {
        
        //let loginSwifter = Swifter(consumerKey: consumerKey, consumerSecret: consumerSecret)
        guard let url = URL(string: "twitterapp://success") else { return }
        loginSwifter.authorize(with: url, presentFrom: self, success: { (_) in
            print("success")
            }) { (error) in
                print("\(error)")
        }
        
        
    }
 
 */
    
    func navigateToScheduleScreen() {
        performSegue(withIdentifier: "toScheduleView", sender: self)
    }
    
    @IBAction func loginButtonPressed(_ sender: AnyObject) {
        Twitter.sharedInstance().logIn { (session, error) in
            if session != nil {
            
                //guard let userID = session.userID else { return }
                self.navigateToScheduleScreen()
                UserDefaults.standard.set(session?.userID, forKey: "userID")
                
                
               Answers.logLogin(withMethod: "Twitter", success: true, customAttributes: ["User ID": session!.userID])
                
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
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
