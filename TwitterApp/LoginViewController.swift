//
//  LoginViewController.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/18/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit
import SafariServices


class LoginViewController: UIViewController, TwitterProtocol, SFSafariViewControllerDelegate {
    var loginSwifter: Swifter
    
    required init?(coder aDecoder: NSCoder) {
        
        self.loginSwifter = Swifter(consumerKey: "ADeOdA9e5XfjJtchq0iWetwpY" , consumerSecret: "7XlXJOe97gpqyu5GYtWY5isOwy4YEvnin1Rr8m0g5GMs6pD3WR")
        super.init(coder: aDecoder)
        
    }
    
    func login() {
        
        //let loginSwifter = Swifter(consumerKey: consumerKey, consumerSecret: consumerSecret)
        guard let url = URL(string: "twitterapp://success") else { return }
        loginSwifter.authorize(with: url, presentFrom: self, success: { (token, response) in
            print(token?.key)
            print("success")
        }) { (error) in
            print("FAIL \(error.localizedDescription)")
        }
        
        
    }
    
    @IBAction func loginButtonPressed(_ sender: AnyObject) {
        self.login()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
