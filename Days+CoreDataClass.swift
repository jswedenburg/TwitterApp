//
//  Days+CoreDataClass.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/10/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import Foundation
import CoreData


public class Days: NSManagedObject {

    convenience init(day: Int16, schedule: Schedule = Schedule(), context:NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.day = day
        self.schedule = schedule
    }
}
