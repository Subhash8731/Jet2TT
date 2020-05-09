/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Singleton controller to manage the main Core Data stack for the application. It vends a persistent store coordinator, the managed object model, and a URL for the persistent store.
 */


import CoreData
import SwiftCSV

class CoreDataStackManager {
    
   
    static let sharedManager = CoreDataStackManager()
    
    private init() {} // Prevent clients from creating another instance.
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Jet2TT")
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

// #Define helper methods here for saving and retriving data from database
extension CoreDataStackManager {
    
   
    func saveArticle(with data:[Articles]) {
        let context = self.persistentContainer.viewContext
        
        for user in data {
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "Jet2TT", into: context)
            newUser.setValue(user.dictionaryRepresentation().jsonString, forKey: "data")
        }
        do {
            try context.save()
            print("Success")
        } catch {
            print("Error saving: \(error)")
        }
    }
   
    func getAllArticles() -> [Articles] {
        let context = self.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Jet2TT", in: context)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        //fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: ascneding)]
       // fetchRequest.predicate = NSPredicate(format: "id = %@",self.user)
        fetchRequest.entity = entity
        
        return queryForDiary(with: fetchRequest)
        
    }
    
    func queryForDiary(with fetchRequest:NSFetchRequest<NSFetchRequestResult>) -> [Articles] {
        
        var results = [Articles]()
       
        let context = self.persistentContainer.viewContext
        do {
                if let fetchResult = try context.fetch(fetchRequest) as? [NSManagedObject] {
                       for object in fetchResult {
                           let data = object.value(forKey: "data") as? String
                           if let dict = data?.toDictionary(),let dairy = Articles(dictionary: dict) {
                               results.append(dairy)
                           }
                       }
                   }
               } catch {
               }
               return results
    }
    
  
    
}
