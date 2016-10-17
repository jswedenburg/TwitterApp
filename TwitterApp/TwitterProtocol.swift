//
//  TwitterProtocol.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/17/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import Foundation

protocol TwitterProtocol {
    var consumerKey: String { get }
    var consumerSecret: String { get }
    var accessToken: String { get }
    var tokenSecret: String { get } 
    
    
}

extension TwitterProtocol {
    
    var consumerKey: String {
        get {
           return "ADeOdA9e5XfjJtchq0iWetwpY"
        }
    }
    
    var consumerSecret: String {
        get {
            return "7XlXJOe97gpqyu5GYtWY5isOwy4YEvnin1Rr8m0g5GMs6pD3WR"
        }
    }
    
    var accessToken: String {
        get {
            return "45428809-NhJAMwJshILhzUrO16A5pHpgmEbRKbm1KQJwvuB52"
        }
    }
    
    var tokenSecret: String {
        get {
            return "BiTchVQ5V0dE1PxUHIIGFzlCRrh25gaGq1oGPMlbP9yzK"
        }
    }
    
    
}
