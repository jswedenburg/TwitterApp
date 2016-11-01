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
    
    
    
   
 
    
    func add(_ day: Days){
        ScheduleController.sharedController.saveToPersistentStorage()
        
    }
    
    func delete(_ day: Days){
        let moc = ScheduleController.sharedController.moc
        
        moc.delete(day)
        
        ScheduleController.sharedController.saveToPersistentStorage()
    }
    
    

    
    
}
