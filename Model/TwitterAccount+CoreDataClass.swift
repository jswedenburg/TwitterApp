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

    convenience init(context: NSManagedObjectContext = CoreDataStack.context){
        
        self.init(context: context)
    }
}
