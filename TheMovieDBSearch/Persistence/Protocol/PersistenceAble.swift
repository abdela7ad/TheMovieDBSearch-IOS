//
//  PersistenceAble.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 7/29/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation
import CoreData
// protocol for Entities to be identiable on DB Provider (CoreData,Realm..etc)
public protocol PersistenceAble {
    
}

/* Allow NSManagedObject to be PersistenceAble by default
 same for Object as Realm and NSObject  for FDBM
 */
extension NSManagedObject: PersistenceAble {
    
}

/*
    All operation that can done on PersistenceAble Entity (Save , update , fetch...etc)
 */
protocol PersistenceOperation {
    /*
     Create a new object with default values
     return an object that is conformed to the `PersistenceAble` protocol
     */
    func create<T: PersistenceAble>(_ model: T.Type) throws  -> T
    
    /*
     Save an object that is conformed to the `PersistenceAble` protocol
     */
    func save(object: PersistenceAble) throws
    
    
    /*
     Return a list of objects that are conformed to the `PersistenceAble` protocol
     */
    func fetch<T: PersistenceAble>(_ model: T.Type, predicate: NSPredicate?, sorted: NSSortDescriptor?) -> [T]
}

