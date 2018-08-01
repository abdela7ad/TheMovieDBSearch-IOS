//
//  CoreDataPersistance.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 7/30/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation
import CoreData
class CoreDataPersistance  {
    
    let persistentContainer: NSPersistentContainer
    
    // MARK: Init with dependency
    init(container: NSPersistentContainer = AppDelegate.persistentContainer) {
        self.persistentContainer = container
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }

    lazy var context :  NSManagedObjectContext = {
        let  context = AppDelegate.viewContext
        //To make suggest query unique  we use NSMergeByPropertyObjectTrumpMergePolicy
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy 
        return context
    }()
    
    func saveContext() throws{
        if context.hasChanges {
            try context.save()
        }
    }
}
