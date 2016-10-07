//
//  NetworkController.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/6/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import Foundation

class NetworkController {
    
    enum HTTPMethod: String {
        case Get = "GET"
        case Put = "PUT"
        case Post = "POST"
        case Patch = "PATCH"
        case Delete = "DELETE"
    }
    
    
    static func performRequestForURL(url: NSURL, httpMethod: HTTPMethod, urlParameters: [String:String]? = nil, body: NSData? = nil, completion: ((_ data: NSData?, _ error: NSError?) -> Void)?){
        
        // Creating a request
        let requestURL = urlFromURLParameters(url: url, urlParameters: urlParameters)
        let request = NSMutableURLRequest(url: requestURL as URL)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body as Data?
        
        //Execute the request
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let completion = completion {
                completion(data as NSData?, error as NSError?)
            }
        }
        
        
        
        dataTask.resume()
        
    }
    
    static func urlFromURLParameters(url: NSURL, urlParameters: [String: String]?) -> NSURL {
        let components = NSURLComponents(url: url as URL, resolvingAgainstBaseURL: true)
        
        components?.queryItems = urlParameters?.flatMap({(NSURLQueryItem(name: $0.0, value: $0.1) as URLQueryItem)})
        
        if let url = components?.url {
            return url as NSURL
        } else {
            fatalError("URL optional is nil")
        }
    }
    
    
}
