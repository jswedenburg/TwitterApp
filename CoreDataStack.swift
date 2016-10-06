//
//  CoreDataStack.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/5/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TwitterApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Error loading persistant stores: \(error)")
            }
        })
        return container
    }()
    
    static var context: NSManagedObjectContext { return container.viewContext }
}

