//
//  Database.swift
//  BT_CoreData
//
//  Created by Hiroshi.Kazuo on 3/25/17.
//  Copyright © 2017 Hiroshi.Kazuo. All rights reserved.
//
//  Supports:
//    static var MOC
//    static func create
//      static func insert
//      static func delete
//      static func reset
//      static func clear
//    static func save
//
//    static func select
//    static func count
//    static func isExistAndGet
//    static func isExist
//    static func isEmpty
//    static func selectAndGroupBy
//
//  Version 1.4
//  Change-log:
//      - 1.1: Remove func seedData.
//      - 1.2: Remove module Immediate.
//      - 1.3: Add isEmpty.
//      - 1.4: Add selectAndGroupBy.
//

import UIKit
import CoreData

//  CoreData: Enable AppDelegate-Context (Swift 3)
//==================================================
//extension AppDelegate {
//    // MARK: - Core Data stack
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "BT_CoreData")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//}
//==================================================

class Database {
    static var MOC: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static func save() {
        if MOC.hasChanges {
            do {
                try MOC.save()
            }
            catch let error as NSError {
                print("Cannot save db \(error)")
            }
        }
    }
    
    static func reset() {
        MOC.reset()
    }
    
    static func insert<T: NSManagedObject>(object: T) {
        MOC.insert(object)
    }
    
    static func delete<T: NSManagedObject>(object: T) {
        MOC.delete(object)
    }
    
    static func create<T: NSManagedObject>() -> T {
        return NSEntityDescription.insertNewObject(forEntityName: GenericTypeHelper<T>.genericName(), into: MOC) as! T
    }
    
    static func create(entityName: String) -> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: MOC)
    }
    
    static func select<T: NSManagedObject>(predicater: NSPredicate? = nil, sorter: [NSSortDescriptor]? = nil) -> [T] {
        let entityName = GenericTypeHelper<T>.genericName()
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: entityName)
        fetchRequest.predicate = predicater
        fetchRequest.sortDescriptors = sorter
        do {
            return try MOC.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [T]
        } catch let error as NSError {
            print("Cannot get all from entity \(entityName), error: \(error), \(error.userInfo)")
            return []
        }
    }
    
    static func select(entityName: String, predicater: NSPredicate? = nil, sorter: [NSSortDescriptor]? = nil) -> [NSManagedObject] {
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: entityName)
        fetchRequest.predicate = predicater
        fetchRequest.sortDescriptors = sorter
        do {
            return try MOC.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [NSManagedObject]
        } catch let error as NSError {
            print("Cannot get all from entity \(entityName), error: \(error), \(error.userInfo)")
            return []
        }
    }
    
    static func select<T: NSManagedObject>(limit: Int, predicater: NSPredicate? = nil, sorter: [NSSortDescriptor]? = nil) -> [T] {
        let entityName = GenericTypeHelper<T>.genericName()
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: entityName)
        fetchRequest.fetchLimit = limit
        fetchRequest.predicate = predicater
        fetchRequest.sortDescriptors = sorter
        do {
            return try MOC.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [T]
        } catch let error as NSError {
            print("Cannot get all from entity \(entityName), error: \(error), \(error.userInfo)")
            return []
        }
    }
    
    static func select(entityName: String, limit: Int, predicater: NSPredicate? = nil, sorter: [NSSortDescriptor]? = nil) -> [NSManagedObject] {
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: entityName)
        fetchRequest.fetchLimit = limit
        fetchRequest.predicate = predicater
        fetchRequest.sortDescriptors = sorter
        do {
            return try MOC.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [NSManagedObject]
        } catch let error as NSError {
            print("Cannot get all from entity \(entityName), error: \(error), \(error.userInfo)")
            return []
        }
    }
    
    static func count(entityName: String, predicater: NSPredicate? = nil) -> Int {
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: entityName)
        fetchRequest.predicate = predicater
        do {
            return try MOC.count(for: fetchRequest)
        } catch let error as NSError {
            print("Cannot count from entity \(entityName), error: \(error), \(error.userInfo)")
            return -1
        }
    }
    
    static func isExistAndGet<T: NSManagedObject>(predicater: NSPredicate?) -> T? {
        let results: [T] = select(limit: 1, predicater: predicater)
        if results.count > 0 {
            return results.first
        }
        return nil
    }
    
    static func isExistAndGet(entityName: String, predicater: NSPredicate?) -> NSManagedObject? {
        let results: [NSManagedObject] = select(entityName: entityName, limit: 1, predicater: predicater)
        if results.count > 0 {
            return results.first
        }
        return nil
    }
    
    static func isExist(entityName: String, predicater: NSPredicate?) -> Bool {
        return select(entityName: entityName, limit: 1, predicater: predicater).count > 0
    }
    
    static func isEmpty(entityName: String) -> Bool {
        return select(entityName: entityName, limit: 1).count == 0
    }
    
    static func clear(entityName: String) {
        for obj in Database.select(entityName: entityName) {
            Database.delete(object: obj)
        }
    }
    
    static func selectAndGroupBy<T: NSManagedObject>(groupByColumn: String, predicater: NSPredicate? = nil, sorter: [NSSortDescriptor]? = nil) -> NSFetchedResultsController<T> {
        let entityName = GenericTypeHelper<T>.genericName()
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: entityName)
        
        var sorters = [NSSortDescriptor]()
        let defaultSorter = NSSortDescriptor(key: groupByColumn, ascending: true)
        sorters.append(defaultSorter)
        if sorter != nil {
            for each in sorter! {
                sorters.append(each)
            }
        }
        
        fetchRequest.predicate = predicater
        fetchRequest.sortDescriptors = sorters

        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: MOC, sectionNameKeyPath: groupByColumn, cacheName: nil)

        do {
            try aFetchedResultsController.performFetch()
        } catch let error {
            print("Unresolved error \(error), \(error._userInfo)")
            abort()
        }

       return aFetchedResultsController
    }
    
    static func selectAndGroupBy(entityName: String, groupByColumn: String, predicater: NSPredicate? = nil, sorter: [NSSortDescriptor]? = nil) -> NSFetchedResultsController<NSManagedObject> {
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: entityName)
        
        var sorters = [NSSortDescriptor]()
        let defaultSorter = NSSortDescriptor(key: groupByColumn, ascending: true)
        sorters.append(defaultSorter)
        if sorter != nil {
            for each in sorter! {
                sorters.append(each)
            }
        }
        
        fetchRequest.predicate = predicater
        fetchRequest.sortDescriptors = sorters
        
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: MOC, sectionNameKeyPath: groupByColumn, cacheName: nil)

        do {
            try aFetchedResultsController.performFetch()
        } catch let error {
            print("Unresolved error \(error), \(error._userInfo)")
            abort()
        }

       return aFetchedResultsController
    }
    
    static func selectAndGroupBy<T: NSManagedObject>(limit: Int, groupByColumn: String, predicater: NSPredicate? = nil, sorter: [NSSortDescriptor]? = nil) -> NSFetchedResultsController<T> {
        let entityName = GenericTypeHelper<T>.genericName()
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: entityName)
        
        var sorters = [NSSortDescriptor]()
        let defaultSorter = NSSortDescriptor(key: groupByColumn, ascending: true)
        sorters.append(defaultSorter)
        if sorter != nil {
            for each in sorter! {
                sorters.append(each)
            }
        }
        
        fetchRequest.fetchLimit = limit
        fetchRequest.predicate = predicater
        fetchRequest.sortDescriptors = sorters

        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: MOC, sectionNameKeyPath: groupByColumn, cacheName: nil)

        do {
            try aFetchedResultsController.performFetch()
        } catch let error {
            print("Unresolved error \(error), \(error._userInfo)")
            abort()
        }

       return aFetchedResultsController
    }
    
    static func selectAndGroupBy(entityName: String, limit: Int, groupByColumn: String, predicater: NSPredicate? = nil, sorter: [NSSortDescriptor]? = nil) -> NSFetchedResultsController<NSManagedObject> {
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: entityName)
        
        var sorters = [NSSortDescriptor]()
        let defaultSorter = NSSortDescriptor(key: groupByColumn, ascending: true)
        sorters.append(defaultSorter)
        if sorter != nil {
            for each in sorter! {
                sorters.append(each)
            }
        }
        
        fetchRequest.fetchLimit = limit
        fetchRequest.predicate = predicater
        fetchRequest.sortDescriptors = sorters
        
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: MOC, sectionNameKeyPath: groupByColumn, cacheName: nil)

        do {
            try aFetchedResultsController.performFetch()
        } catch let error {
            print("Unresolved error \(error), \(error._userInfo)")
            abort()
        }

       return aFetchedResultsController
    }
}
