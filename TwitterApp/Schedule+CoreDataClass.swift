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

    convenience init(repeating: Bool = false, startTime: Date = Date(), endTime: Date = Date(), title: String, enabled: Bool = false, context: NSManagedObjectContext = CoreDataStack.context){
        
        
        
        self.init(context: context)
        self.repeating = repeating
        self.startTime = startTime
        self.endTime = endTime
        self.title = title
        self.enabled = enabled
        
        
        
        
    }

    
}
