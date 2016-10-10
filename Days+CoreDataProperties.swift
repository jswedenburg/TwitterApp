//
//  Days+CoreDataProperties.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/10/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import Foundation
import CoreData
  

extension Days {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Days> {
        return NSFetchRequest<Days>(entityName: "Days");
    }

    @NSManaged public var day: Int16
    @NSManaged public var schedule: Schedule?

}
