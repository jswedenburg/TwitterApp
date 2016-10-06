//
//  Schedule+CoreDataClass.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/6/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import Foundation
import CoreData


public class Schedule: NSManagedObject {

    convenience init(repeating: Bool, days: Int16 = 1, startTime: NSDate = NSDate(), endTime: NSDate = NSDate(), twitterAccounts: [TwitterAccount] = [], context: NSManagedObjectContext = CoreDataStack.context){
        
        
        
        self.init(context: context)
        self.repeating = repeating
        self.days = days
        self.startTime = startTime as NSDate
        self.endTime = endTime as NSDate
        self.twitterAccounts = NSSet(array: twitterAccounts)
        
        
        
        
    }

    
}
