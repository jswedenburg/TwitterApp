//
//  AppDelegate.swift
//  TwitterApp
//
//  Created by Jake SWEDENBURG on 10/5/16.
//  Copyright © 2016 Jake Swedenbug. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
import Fabric
import TwitterKit
import Fabric
import Answers


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       // Fabric.with([Twitter.self])
        Fabric.with([Twitter.self, Answers.self])
        
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let loginVC = storyboard.instantiateViewController(withIdentifier: "loginVC") as? LoginViewController,
            let navVC = storyboard.instantiateViewController(withIdentifier: "navcontroller") as? UINavigationController else { return true }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        
        if UserDefaults.standard.value(forKey: "userID") != nil || hasAppBeenUpdatedSinceLastRun() == false {
            appDelegate.window?.rootViewController = navVC
            appDelegate.window?.makeKeyAndVisible()
        } else {
            appDelegate.window?.rootViewController = loginVC
            appDelegate.window?.makeKeyAndVisible()
        }
            

        
        // Override point for customization after application launch.
        return true
    }
    
    func hasAppBeenUpdatedSinceLastRun() -> Bool {
        var bundleInfo = Bundle.main.infoDictionary!
        let userDefaults = UserDefaults.standard
        if let currentVersion = bundleInfo["CFBundleShortVersionString"] as? String {
            if userDefaults.string(forKey: "currentVersion") == currentVersion {
                return false
            } else {
                userDefaults.set(currentVersion, forKey: "currentVersion")
                userDefaults.synchronize()
                return true
            }
        }
        return true
    }
        
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        //Swifter.handleOpenURL(url)
        return true
    }

    
    
    
    

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "TwitterApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

