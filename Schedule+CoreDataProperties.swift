//
//  Schedule+CoreDataProperties.swift
//  TwitterApp
//
//  Created by Jake Swedenburg on 10/31/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import Foundation
import CoreData


extension Schedule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Schedule> {
        return NSFetchRequest<Schedule>(entityName: "Schedule");
    }

    @NSManaged public var enabled: Bool
    @NSManaged public var title: String?
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
