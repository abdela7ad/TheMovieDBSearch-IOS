//
//  ViewModelsTest.swift
//  TheMovieDBSearchTests
//
//  Created by Abdelahad on 8/1/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation

import XCTest
@testable import TheMovieDBSearch

class ViewModelsTest: XCTestCase {
    
    private let movieClient = MovieDBProvider()
    let persistance = CoreDataPersistance()
    let resultViewModel = ResultsViewModel()
    let searchViewModel = SearchMoviesViewModel()
    let resultViewState =  ResultViewSourceViewState.suggest([SuggestStorage]())
    let selectedIndex =  State.suggest

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadingState() {
        
        resultViewModel.searchQuery = "Batman"
        
        resultViewModel.fetchMovies()

        // test loading case
        let exp = expectation(description: "Test Loading state")
        let res = XCTWaiter.wait(for: [exp], timeout: 0.2) /// small time to test loading cas
        if res == XCTWaiter.Result.completed {
        } else {
            XCTAssertEqual(resultViewModel.selectedIndex, State.loading)
        }

    }
    
    
    func testReadyState() {
        
        resultViewModel.searchQuery = "Batman"
        
        resultViewModel.fetchMovies()
        
        // test loading case
        let exp = expectation(description: "Test Ready state")
        let res = XCTWaiter.wait(for: [exp], timeout: 4) /// small time to test loading cas
        if res == XCTWaiter.Result.completed {
        } else {
            XCTAssertEqual(resultViewModel.selectedIndex, State.ready)
        }
        
    }
    
    
    func testNoresultErrorState() {
        
        resultViewModel.searchQuery = "thereisnoresultforthat$$$$"
        
        resultViewModel.fetchMovies()
        
        // test loading case
        let exp = expectation(description: "Test Error state")
        let res = XCTWaiter.wait(for: [exp], timeout: 5) /// small time to test loading cas
        if res == XCTWaiter.Result.completed {
        } else {
            XCTAssertEqual(resultViewModel.selectedIndex, State.error)
        }
        
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
    
    
    
  
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
