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
    static let consumerSecret = "7XlXJOe97gpqyu5GYtWY5isOwy4YEvnin1Rr8m0g5GMs6pD3WR"
    static let tokenSecret = "BiTchVQ5V0dE1PxUHIIGFzlCRrh25gaGq1oGPMlbP9yzK"
    static let version = "1.0"
    
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
        
        let signature = generateSignature(url: url, httpMethod: httpMethod, parameters: urlParameters)
        let authHeaderValue = "OAuth oauth_consumer_key=\"\(consumerKey)\", oauth_nonce=\"\(nonce)\", oauth_signature=\"\(signature)\", oauth_signature_method=\"\(signatureMethod)\", oauth_timestamp=\"\(timeStamp)\", oauth_token=\"\(accessToken)\", oauth_version=\"\(version)\""
        
        let twitterHeaderAuth = "OAuth oauth_consumer_key=\"ADeOdA9e5XfjJtchq0iWetwpY\", oauth_nonce=\"2932bb1e59311739de386a4dc0818fb7\", oauth_signature=\"GAUBccqjeEdd2ZWuYLGp82gkTkg%3D\", oauth_signature_method=\"HMAC-SHA1\", oauth_timestamp=\"1476299950\", oauth_token=\"45428809-NhJAMwJshILhzUrO16A5pHpgmEbRKbm1KQJwvuB52\", oauth_version=\"1.0\""
        
        // Creating a request
        let requestURL = urlFromURLParameters(url: url, urlParameters: urlParameters)
        let request = NSMutableURLRequest(url: requestURL as URL)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body as Data?
        request.addValue(twitterHeaderAuth, forHTTPHeaderField: "Authorization")
        
        
        //Execute the request
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let completion = completion {
                completion(data as NSData?, error as NSError?)
            }
        }
        dataTask.resume()
        
    }
    
    static func generateSignature(url: URL, httpMethod: HTTPMethod, parameters: [String: String]) -> String {
        let urlString = String(describing: url)
        var newCharacterSet = CharacterSet.alphanumerics
        newCharacterSet.formUnion(CharacterSet.init(charactersIn: "."))
        let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: newCharacterSet)
        
        let httpString = httpMethod.rawValue
       
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
                thirdString += encodedKey! + "=" + encodedValue!
            }
            
            
        }
        
        let parameterString = "\(firstString)oauth_consumer_key=\(consumerKey)&oauth_nonce=\(nonce)&oauth_signature_method=\(signatureMethod)&oauth_timestamp=\(timeStamp)&oauth_token=\(accessToken)&oauth_version=\(version)\(secondString)\(thirdString)"
        var secondCharacterSet = CharacterSet.alphanumerics
        secondCharacterSet.formUnion(CharacterSet.init(charactersIn: "._-"))
        let encodedParameterString = parameterString.addingPercentEncoding(withAllowedCharacters: secondCharacterSet)
        
        let signatureBaseString = "\(httpString)&\(encodedUrlString!)&\(encodedParameterString!)"
    
        print(signatureBaseString)
        
        let signingKey = "\(consumerSecret)&\(tokenSecret)"
        
        let combined = "\(signatureBaseString)\(signingKey)"
        
        let hmacString = combined.sha1()
        
        return hmacString
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

extension String {
    func sha1() -> String {
        let data = self.data(using: String.Encoding.utf8)!
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA1($0, CC_LONG(data.count), &digest)
        }
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joined()
    }
}
