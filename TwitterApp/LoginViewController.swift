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


class LoginViewController: UIViewController, TwitterProtocol, SFSafariViewControllerDelegate {
    
    
    
    
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
    
    @IBAction func loginButtonPressed(_ sender: AnyObject) {
        //self.login()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "scheduleTVC") as? ScheduleTableViewController else { return }
        let logInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                let alert = UIAlertController(title: "Logged In",
                                              message: "User \(unwrappedSession.userName) has logged in",
                    preferredStyle: UIAlertControllerStyle.alert
                )
                let action = UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
                    self.present(vc, animated: true, completion: nil)
                })
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                //self.present(ScheduleTableViewController(), animated: true, completion: nil)
            } else {
                NSLog("Login error: %@", error!.localizedDescription);
            }
            
            
        }
        
        // TODO: Change where the log in button is positioned in your view
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)

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
