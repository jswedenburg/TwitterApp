//
//  TwitterAccount+CoreDataClass.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/5/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import Foundation
import CoreData


public class TwitterAccount: NSManagedObject {
    
    private let kName = "name"
    private let kProfileImage = "profile_image_url"
    private let kScreenName = "screen_name"
    private let kVerified = "verified"

    convenience init?(dictionary: [String:Any], schedule: Schedule = Schedule(), context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        guard let name = dictionary[kName] as? String,
            let profileImageURL = dictionary[self.kProfileImage] as? String,
            let screenName = dictionary[self.kScreenName] as? String,
            let verified = dictionary[self.kVerified] as? Bool else { return nil }
        
        
        
        self.name = name
        self.screenName = screenName
        self.verified = verified
        self.schedule = schedule
        imageDataForURL(urlString: profileImageURL) { (data) in
            self.profileImage = data
        }
    }
    
    
    
    
    func imageDataForURL(urlString: String, completion: @escaping (_ data: NSData) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        NetworkController.performRequestForURL(url: url, httpMethod: .Get) { (data, error) in
            guard let data = data else { return }
            completion(data)
            
            
        }
    }
}
