//
//  ScheduleController.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/5/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import Foundation
import CoreData

class ScheduleController {
    static let sharedController = ScheduleController()
    
    var schedules: [Schedule] {
        
        let request: NSFetchRequest<Schedule> = Schedule.fetchRequest()
        let moc = CoreDataStack.context
        do {
            let result = try moc.fetch(request)
            return result
        } catch {
            return []
        }
    }
    
    func add(_ schedule: Schedule){
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



