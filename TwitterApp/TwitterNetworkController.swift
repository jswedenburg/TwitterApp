//
//  TwitterNetworkController.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/11/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import Foundation

class TwitterNetworkController {
    
    //MARK: Properties
    
    static let baseSearchURL = URL(string: "https://api.twitter.com/1.1/users/search.json")
    
    
    //MARK Function
    
    
    
    static func fetchTwitterAccounts(_ searchTerm: String, completion: @escaping (_ twitterAccounts: [TwitterAccount]) -> Void) {
        guard let url = baseSearchURL  else { return }
        let urlParameters = ["count": "3", "page" : "1", "q": searchTerm]
        
        NetworkController.performRequestForURL(url: url, httpMethod: .Get, urlParameters: urlParameters, body: nil) { (data, error) in
            guard let data = data as? Data else { return }
            guard let jsonDict = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [[String:Any]] else { print("json dict faild")
                return }
            
            let results = jsonDict.flatMap({TwitterAccount(dictionary: $0)})
            completion(results)
            
        }
    }
}
