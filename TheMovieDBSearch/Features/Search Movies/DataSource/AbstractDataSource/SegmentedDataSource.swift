//
//  SearchResultDataSource.swift
//  DataSource
//
//  Created by Abdelahad on 7/28/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation
import UIKit





class SegmentedDataSource:NSObject, DataSource{
   

    /**
     Initialize new instance of the SegmentedDataSource `fatalError`. You should use one of its subclasses.
     */
    public override init() {
        let typeOf = SegmentedDataSource.self
        guard type(of: self) != typeOf else {
            fatalError("\(typeOf) instances can not be created; create a subclass instance instead.")
        }
    }
    
    // to Mapping between diffrent data source
     var selectedDataSourceIndex: Int {
        set{
            precondition(newValue < dataSources.count, "invalid selectedDataSourceIndex, should be less than \(dataSources.count)")
            precondition(newValue >= 0, "invalid selectedDataSourceIndex, should be greater than or equal to 0.")
            selectedDataSource = dataSources[newValue]
        }
        
        get{
           // NSNotFound  A value indicating that a requested item couldn’t be found or doesn’t exist.
           return dataSources.index {$0 === selectedDataSource} ?? NSNotFound
        }
    }

    var  selectedDataSource:DataSource?
    
    
    /// check if Data Source set or not  , used for save access Data source
    var  safeSelectedDataSource :DataSource {
        
        guard let selectedDataSource =  selectedDataSource else {
            fatalError("[\(type(of: self))]: Calling SegmentedDataSource methods with nil selectedDataSource")
        }
        return selectedDataSource
    }
    
    
    // to add data source
    func add(_ dataSource:DataSource){
        dataSources.append(dataSource)
        if selectedDataSource == nil {
            selectedDataSource = dataSource
        }
    }
    
    // handle diffrent datasource
    private(set) var dataSources:[DataSource] = []
   
    
    //MARK:- DataSource and Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return safeSelectedDataSource.tableView(tableView,numberOfRowsInSection:section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return safeSelectedDataSource.tableView(tableView,cellForRowAt:indexPath)
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if safeSelectedDataSource.responds(to: #selector(tableView(_:heightForRowAt:))) {
            return safeSelectedDataSource.tableView!(tableView , heightForRowAt:indexPath)
        }
      return 0.0
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if safeSelectedDataSource.responds(to: #selector(tableView(_:shouldHighlightRowAt:))) {
            return safeSelectedDataSource.tableView!(tableView,shouldHighlightRowAt:indexPath)
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if safeSelectedDataSource.responds(to: #selector(tableView(_:didSelectRowAt:))) {
            return safeSelectedDataSource.tableView!(tableView,didSelectRowAt:indexPath)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        return safeSelectedDataSource.scrollViewDidEndDecelerating!(scrollView)
    }
}

