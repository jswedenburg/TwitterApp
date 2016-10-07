//
//  TwitterAccountController.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/7/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import Foundation
import CoreData

class TwitterAccountController {
    static let sharedController = TwitterAccountController()
    
    var twitterAccounts: [TwitterAccount] {
        
        let request: NSFetchRequest<TwitterAccount> = TwitterAccount.fetchRequest()
        let moc = CoreDataStack.context
        do {
            let result = try moc.fetch(request)
            return result
        } catch {
            return []
        }
    }
    
    func add(_ twitterAccount: TwitterAccount){
        self.saveToPersistentStorage()
        
    }
    
    func delete(_ twitterAccount: TwitterAccount){
        twitterAccount.managedObjectContext?.delete(twitterAccount)
        
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
