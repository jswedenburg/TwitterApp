//
//  NetworkController.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/6/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import Foundation
import TwitterKit



class NetworkController {
    
    enum HTTPMethod: String {
        case Get = "GET"
        case Put = "PUT"
        case Post = "POST"
        case Patch = "PATCH"
        case Delete = "DELETE"
    }
    
    //MARK: Search function
    static func searchRequest(searchTerm: String, completion: @escaping (_ accounts: [TwitterAccount], _ error: Bool) -> Void) {
        guard let userID = Twitter.sharedInstance().sessionStore.session()?.userID else { completion([], true)
            return }
        let client = TWTRAPIClient(userID: userID)
        let searchEndPoint = "https://api.twitter.com/1.1/users/search.json"
        let params = ["q": "\(searchTerm)", "page": "1", "count": "20"]
        var clientError: NSErrorPointer
        
        let request = client.urlRequest(withMethod: "GET", url: searchEndPoint, parameters: params, error: clientError)
        client.sendTwitterRequest(request) { (response, data, error) in
            if error != nil {
                completion([], true)
            }
            var accountArray: [TwitterAccount] = []
            guard let data = data else { return }
            guard let jsonDict = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [[String: Any]] else { return }
            for x in 0...(jsonDict.count - 1) {
                guard let name = jsonDict[x]["name"] as? String, let screenName = jsonDict[x]["screen_name"] as? String, let imageURL = jsonDict[x]["profile_image_url"] as? String, let verified = jsonDict[x]["verified"] as? Bool else { return }
                let biggerImage = imageURL.replacingOccurrences(of: "_normal", with: "")
                guard let url = URL(string: biggerImage) else { return }
                print(verified)
                NetworkController.performRequestForURL(url: url, httpMethod: .Get) { (data, error) in
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        let newAccount = TwitterAccount(name: name, screenName: screenName, verified: verified, schedule: nil, profileImageData: data)
                        accountArray.append(newAccount)
                        completion(accountArray, false)
                    }
                }
            }
        }
    }
    
    //MARK: Retrieve image data function
    static func imageDataForURL(urlString: String, completon: @escaping ((_ data: Data) -> Void)) {
        guard let url = URL(string: urlString) else { return }
        NetworkController.performRequestForURL(url: url, httpMethod: .Get) { (data, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                completon(data)
            }
        }
    }
    
    //MARK: Generic Network request
    static func performRequestForURL(url: URL, httpMethod: HTTPMethod, urlParameters: [String:String]? = nil, body: Data? = nil, completion: ((_ data: Data?, _ error: Error?) -> Void)?){
        
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
    
    //MARK: Helper Function
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



