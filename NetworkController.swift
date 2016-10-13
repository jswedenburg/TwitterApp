//
//  NetworkController.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/6/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import Foundation



class NetworkController {
    
    static let consumerKey = "ADeOdA9e5XfjJtchq0iWetwpY"
    static let accessToken = "45428809-NhJAMwJshILhzUrO16A5pHpgmEbRKbm1KQJwvuB52"
    static let consumerSecret = "7XlXJOe97gpqyu5GYtWY5isOwy4YEvnin1Rr8m0g5GMs6pD3WR"
    static let tokenSecret = "BiTchVQ5V0dE1PxUHIIGFzlCRrh25gaGq1oGPMlbP9yzK"
    
    
    
    
    static func twitterSearch(searchTerm: String, completion: @escaping ([TwitterAccount]) -> Void) {
        var swifter = Swifter(consumerKey: consumerKey, consumerSecret: consumerSecret, oauthToken: accessToken, oauthTokenSecret: tokenSecret)
        
        swifter.searchUsers(using: searchTerm, page: 1, count: 5, includeEntities: nil, success: { (users) in
            var accountArray: [TwitterAccount] = []
            
            for x in 0...4 {
                guard let name = users[x]["name"].string,
                    let profileImageString = users[x]["profile_image_url"].string,
                    let screenName = users[x]["screen_name"].string,
                    let verified = users[x]["verified"].bool else { return }
                
                guard let url = URL(string: profileImageString) else { return }
                
                
                NetworkController.performRequestForURL(url: url, httpMethod: .Get) { (data, error) in
                    guard let data = data else { return }
                    DispatchQueue.main.async() {
                        let newAccount = TwitterAccount(name: name, screenName: screenName, verified: verified, profileImageData: data)
                        accountArray.insert(newAccount, at: 0)
                        completion(accountArray)
                        
                    }
                }
            }
        })
            
        { (_) in
            print("FAIL")
        }
    }
    
    enum HTTPMethod: String {
        case Get = "GET"
        case Put = "PUT"
        case Post = "POST"
        case Patch = "PATCH"
        case Delete = "DELETE"
    }
    
    
    static func performRequestForURL(url: URL, httpMethod: HTTPMethod, urlParameters: [String:String]? = nil, body: Data? = nil, completion: ((_ data: Data?, _ error: Error?) -> Void)?){
        
        //Create a signature
        
        
        // Creating a request
        let requestURL = urlFromURLParameters(url: url, urlParameters: urlParameters)
        let request = NSMutableURLRequest(url: requestURL as URL)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        
        
        
        //Execute the request
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let completion = completion {
                completion(data, error)
            }
        }
        dataTask.resume()
        
    }
    
    
    static func urlFromURLParameters(url: URL, urlParameters: [String: String]?) -> URL {
        let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true)
        
        components?.queryItems = urlParameters?.flatMap({(NSURLQueryItem(name: $0.0, value: $0.1) as URLQueryItem)})
        
        if let url = components?.url {
            return url
        } else {
            fatalError("URL optional is nil")
        }
    }
    
    
}



