//
//  TwitterAccount+CoreDataProperties.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/5/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import Foundation
import CoreData
import 

extension TwitterAccount {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TwitterAccount> {
        return NSFetchRequest<TwitterAccount>(entityName: "TwitterAccount");
    }

    @NSManaged public var name: String?
    @NSManaged public var profileImage: NSData?
    @NSManaged public var screenName: String?
    @NSManaged public var verified: Bool
    @NSManaged public var schedule: Schedule?

}
