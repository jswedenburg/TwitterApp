//
//  LoginViewController.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/18/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    @IBAction func loginButtonPressed(_ sender: AnyObject) {
        LogInController.sharedController.login()
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
