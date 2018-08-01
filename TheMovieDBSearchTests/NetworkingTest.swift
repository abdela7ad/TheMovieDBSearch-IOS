//
//  NetworkingTest.swift
//  TheMovieDBSearchTests
//
//  Created by Abdelahad on 8/1/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation

import XCTest
@testable import TheMovieDBSearch

class NetworkingTest: XCTestCase {
    
    private let movieClient = MovieDBProvider()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testResultSearchAPI() {
        let exp = self.expectation(description: "waiting for Search result")
        
        movieClient.getMovies(searchQuery: "Batman", page: 1) { (movies, paging, error) in
            
            XCTAssert(movies.count > 0)
            XCTAssertNil(error)
            XCTAssertNotNil(paging)
            
            exp.fulfill()
        }
        
        self.waitForExpectations(timeout: 5)
    }
    
    
    
    func testNoResultSearchAPI() {
        let exp = self.expectation(description: "waiting for No resultSearch result")
        
        movieClient.getMovies(searchQuery: "rqwrqwrqwrwr", page: 1) { (movies, paging, error) in
            
            XCTAssert(movies.count == 0)
            XCTAssertNil(error)
            XCTAssertNotNil(paging)
            
            exp.fulfill()
        }
        
        self.waitForExpectations(timeout: 5)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
