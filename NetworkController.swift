//
//  NetworkController.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/6/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import Foundation

class NetworkController {
    
    static private let consumerKey = "ADeOdA9e5XfjJtchq0iWetwpY"
    static let accessToken = "45428809-NhJAMwJshILhzUrO16A5pHpgmEbRKbm1KQJwvuB52"
    static let verson = "1.0"
    
    static let temp = UUID.init().uuidString
    static let nonce = temp.replacingOccurrences(of: "-", with: "")
    
    
    static let signatureMethod = "HMAC-SHA1"
    
    static let timeStamp = String(describing: NSDate().timeIntervalSince1970)
    
    
    
    enum HTTPMethod: String {
        case Get = "GET"
        case Put = "PUT"
        case Post = "POST"
        case Patch = "PATCH"
        case Delete = "DELETE"
    }
    
    
    static func performRequestForURL(url: URL, httpMethod: HTTPMethod, urlParameters: [String:String], body: NSData? = nil, completion: ((_ data: NSData?, _ error: NSError?) -> Void)?){
        
        //Create a signature
        
        generateSignature(url: url, httpMethod: httpMethod, parameters: urlParameters)
        
        // Creating a request
        let requestURL = urlFromURLParameters(url: url, urlParameters: urlParameters)
        let request = NSMutableURLRequest(url: requestURL as URL)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body as Data?
        request.addValue(self.accessToken, forHTTPHeaderField: "Authorization")
        
        
        //Execute the request
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let completion = completion {
                completion(data as NSData?, error as NSError?)
            }
        }
        
        
        
        dataTask.resume()
        
    }
    
    static func generateSignature(url: URL, httpMethod: HTTPMethod, parameters: [String: String]) {
        let urlString = String(describing: url)
        let httpString = httpMethod.rawValue
        var signatureString = ""
        var firstString = ""
        var secondString = ""
        var thirdString = ""
        let sortedKeyArray = Array(parameters.keys).sorted(by: <)
        
        
        for (key, value) in parameters {
            let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            let encodedValue = value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            
            if key == sortedKeyArray[0] {
                firstString += encodedKey! + "=" + encodedValue! + "&"
            } else if key == sortedKeyArray[1] {
                secondString += encodedKey! + "=" + encodedValue! + "&"
            } else {
                thirdString += encodedKey! + "=" + encodedValue! + "$"
            }
            
            signatureString = firstString + secondString + thirdString
        }
        
        signatureString += "oauth_consumer_key" + "=" + consumerKey + "&"
        
        print(signatureString)
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
