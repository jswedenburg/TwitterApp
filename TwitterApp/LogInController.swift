//
//  LogInController.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/17/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit

class LogInController: TwitterProtocol {
    
    static let sharedController = LogInController()
    
    func login() {
        let loginSwifter = Swifter(consumerKey: consumerKey, consumerSecret: consumerSecret)
        guard let url = URL(string: "https://twitter.com/login") else { return }
        loginSwifter.authorize(with: url, presentFrom: LoginViewController(), success:  { (token, response) in
            let token = token
            print(token)
        })
    }
}
