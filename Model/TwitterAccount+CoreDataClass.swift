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

    convenience init(name: String, screenName: String, verified: Bool, schedule: Schedule? = nil, profileImageURL: String, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.name = name
        self.screenName = screenName
        self.verified = verified
        self.schedule = schedule
        imageDataForURL(urlString: profileImageURL) { (data) in
            self.profileImage = data as NSData
        }
    }
    
    
    
    
    func imageDataForURL(urlString: String, completion: @escaping (_ data: Data) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        NetworkController.performRequestForURL(url: url, httpMethod: .Get) { (data, error) in
            guard let data = data else { return }
            completion(data)
            
            
        }
    }
 
 
}
