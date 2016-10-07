//
//  Schedule+CoreDataProperties.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/6/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import Foundation
import CoreData
 

extension Schedule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Schedule> {
        return NSFetchRequest<Schedule>(entityName: "Schedule");
    }

    @NSManaged public var repeating: Bool
    @NSManaged public var days: Int16
    @NSManaged public var startTime: NSDate?
    @NSManaged public var endTime: NSDate?
    @NSManaged public var title: String?
    @NSManaged public var enabled: Bool
    @NSManaged public var twitterAccounts: NSSet?

}

// MARK: Generated accessors for twitterAccounts
extension Schedule {

    @objc(addTwitterAccountsObject:)
    @NSManaged public func addToTwitterAccounts(_ value: TwitterAccount)

    @objc(removeTwitterAccountsObject:)
    @NSManaged public func removeFromTwitterAccounts(_ value: TwitterAccount)

    @objc(addTwitterAccounts:)
    @NSManaged public func addToTwitterAccounts(_ values: NSSet)

    @objc(removeTwitterAccounts:)
    @NSManaged public func removeFromTwitterAccounts(_ values: NSSet)

}
