//
//  Persistance+Operations.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 7/30/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation
import CoreData


extension CoreDataPersistance: PersistenceOperation {
    
    // fetch Limit for suggest
    var fetchLimit : Int {
        return Config.fetchLimit
    }
    
    func fetch<T>(_ model: T.Type, predicate: NSPredicate?, sorted: NSSortDescriptor?) -> [T] where T : PersistenceAble {
        
        guard let object  = (model as? NSManagedObject.Type) else {
            return [T]()
        }
        /// get fetch request
        let request = object.fetchRequest()
        request.fetchLimit = fetchLimit

        // run Filter
        if let predicate = predicate {
            request.predicate = predicate
        }
        
        // run sorting
        if let sorted = sorted {
            request.sortDescriptors = [sorted]
        }
        
        // fetch data
        guard  let objects  = try? context.fetch(request)  , let PersistenceAbles =  objects as? [T] else {
            return[T]()
        }
        return PersistenceAbles
    }
    
    
    
    func save(object: PersistenceAble) throws {
        try saveContext()
    }
    
    func create<T>(_ model: T.Type) throws -> T where T : PersistenceAble {
        
        guard let object  = (model as? NSManagedObject.Type) else {
            throw NSError()
        }
        let PersistenceAble = object.init(entity: object.entity(), insertInto: context) as! T
        return PersistenceAble
    }
}
