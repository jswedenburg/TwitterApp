//
//  Schedule+CoreDataClass.swift
//  TwitterApp
//
//  Created by Jake Swedenburg on 10/31/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import Foundation
import CoreData


public class Schedule: NSManagedObject {
    convenience init(title: String, enabled: Bool = false, context: NSManagedObjectContext = CoreDataStack.context){
        
        self.init(context: context)
        self.title = title
        self.enabled = enabled
    }
}
