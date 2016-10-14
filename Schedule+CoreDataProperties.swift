//
//  Schedule+CoreDataProperties.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/10/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import Foundation
import CoreData


extension Schedule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Schedule> {
        return NSFetchRequest<Schedule>(entityName: "Schedule");
    }

    @NSManaged public var enabled: Bool
    @NSManaged public var endTime: Date?
    @NSManaged public var repeating: Bool
    @NSManaged public var startTime: Date?
    @NSManaged public var title: String?
    @NSManaged public var twitterAccounts: NSSet?
    @NSManaged public var days: NSOrderedSet?

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

// MARK: Generated accessors for days
extension Schedule {

    @objc(insertObject:inDaysAtIndex:)
    @NSManaged public func insertIntoDays(_ value: Days, at idx: Int)

    @objc(removeObjectFromDaysAtIndex:)
    @NSManaged public func removeFromDays(at idx: Int)

    @objc(insertDays:atIndexes:)
    @NSManaged public func insertIntoDays(_ values: [Days], at indexes: NSIndexSet)

    @objc(removeDaysAtIndexes:)
    @NSManaged public func removeFromDays(at indexes: NSIndexSet)

    @objc(replaceObjectInDaysAtIndex:withObject:)
    @NSManaged public func replaceDays(at idx: Int, with value: Days)

    @objc(replaceDaysAtIndexes:withDays:)
    @NSManaged public func replaceDays(at indexes: NSIndexSet, with values: [Days])

    @objc(addDaysObject:)
    @NSManaged public func addToDays(_ value: Days)

    @objc(removeDaysObject:)
    @NSManaged public func removeFromDays(_ value: Days)

    @objc(addDays:)
    @NSManaged public func addToDays(_ values: NSOrderedSet)

    @objc(removeDays:)
    @NSManaged public func removeFromDays(_ values: NSOrderedSet)

}
