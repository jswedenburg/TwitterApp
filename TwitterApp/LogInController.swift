//
//  LogInController.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/17/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit

class LogInController: TwitterProtocol {
    
    
    
    func login {
        let swifterLogin = Swifter(consumerKey: consumerKey, consumerSecret: consumerSecret)
        swifterLogin.authorize(with: <#T##URL#>, presentFrom: <#T##UIViewController?#>, success: <#T##Swifter.TokenSuccessHandler?##Swifter.TokenSuccessHandler?##(Credential.OAuthAccessToken?, URLResponse) -> Void#>, failure: <#T##Swifter.FailureHandler?##Swifter.FailureHandler?##(Error) -> Void#>)
    }
}
