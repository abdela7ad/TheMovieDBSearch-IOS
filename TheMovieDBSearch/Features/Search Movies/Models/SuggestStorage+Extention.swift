//
//  SuggestStorage+CoreDataProperties.swift
//  
//
//  Created by Abdelahad on 7/30/18.
//
//

import Foundation
import CoreData


extension SuggestStorage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SuggestStorage> {
        return NSFetchRequest<SuggestStorage>(entityName: "SuggestStorage")
    }

    @NSManaged public var searchQuery: String
    @NSManaged public var searchQueryDate: Double

}
