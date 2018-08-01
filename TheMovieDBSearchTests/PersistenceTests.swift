//
//  PersistenceTests.swift
//  TheMovieDBSearchTests
//
//  Created by Abdelahad on 7/31/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation
import CoreData
import XCTest
@testable import TheMovieDBSearch

class PersistenceTests: XCTestCase {
    
    let persistance = CoreDataPersistance()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    /// test create object method
    func testCreateEmptyObject() {
        
        let object =  try? self.persistance.create(SuggestStorage.self)
        XCTAssertNotNil( object )
        
    }
    
    func testSaveAndFetch() {
      let count  = self.persistance.fetch(SuggestStorage.self, predicate: nil, sorted: nil)
        XCTAssert(count.count > 0)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
