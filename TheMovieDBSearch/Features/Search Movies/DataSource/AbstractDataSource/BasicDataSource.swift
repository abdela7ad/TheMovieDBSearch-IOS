//
//  BasicDataSource.swift
//  DataSource
//
//  Created by Abdelahad on 7/28/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation
import  UIKit


/// General protocol Grouping UItableView UITableViewDelegate , UITableViewDataSource , UITableViewDataSourcePrefetching
public protocol DataSource:UITableViewDelegate,UITableViewDataSource {}


class BasicDataSource <CellType:UITableViewCell,ItemType> :NSObject, DataSource{
    
    /**
     Initialize new instance of the BasicDataSource `fatalError`. You should use one of its subclasses.
     */
    public override init() {
        let typeOf = BasicDataSource.self
        guard type(of: self) != typeOf else {
            fatalError("\(typeOf) instances can not be created; create a subclass instance instead.")
        }
    }
    
    //  item for datasource
    var items = [ItemType]()
  
    
    //MARK:-  DataSource
    
    // i handel one section can be update later to have more section
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CellType = tableView.dequeueReusableCell(for: indexPath)
        let item : ItemType = items[indexPath.row]
        /// configure datasource deque Process
        configureTableView(tableView, configure: cell, with: item, at: indexPath)
        return cell
    }
    
    
    
    //MARK:- Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item : ItemType = items[indexPath.row]
        selectionHanlder(tableView ,cellwith: item, at: indexPath)

    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    /// for selection
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }


    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // does nothing
        // should be overriden by subclasses
    }
    
    public func selectionHanlder(_ tableView: UITableView, cellwith item: ItemType, at indexPath: IndexPath) {
        // does nothing
        // should be overriden by subclasses
    }
    public func configureTableView(_ tableView: UITableView, configure cell: CellType, with item: ItemType, at indexPath: IndexPath) {
        // does nothing
        // should be overriden by subclasses
    }
    
    
}
