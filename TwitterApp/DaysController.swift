//
//  DaysController.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/10/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import Foundation
import CoreData

class DaysController {
    static let sharedController = DaysController()
    
    var days: [Days] {
        
        let request: NSFetchRequest<Days> = Days.fetchRequest()
        let moc = CoreDataStack.context
        do {
            let result = try moc.fetch(request)
            return result
        } catch {
            return []
        }
    }
    
    func add(_ day: Days){
        self.saveToPersistentStorage()
        
    }
    
    func delete(_ day: Days){
        day.managedObjectContext?.delete(day)
        
        self.saveToPersistentStorage()
    }
    
    
    
    func saveToPersistentStorage() {
        do {
            try CoreDataStack.context.save()
        } catch {
            NSLog("Error saving to core data: \(error)")
        }
    }
    
    
}
