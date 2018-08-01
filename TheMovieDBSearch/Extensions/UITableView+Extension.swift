//
//  UITableView+Extention.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 7/27/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<T:UITableViewCell>(nibCell cell:T.Type){
        self.register(T.nib, forCellReuseIdentifier: T.reuseID)
    }
    
    func register<T:UITableViewCell>(classCell cell:T.Type){
        self.register(cell.self, forCellReuseIdentifier: cell.reuseID)
    }
    
    
    func dequeueReusableCell<T:UITableViewCell>(for indexPath:IndexPath) -> T{
       guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseID, for: indexPath) as? T else {
            fatalError("")
        }
        return cell
    }
    
    /// set datasource delegate,prefetchDataSource in one line code
    ///
    /// - Parameter dataSource: General protocol Grouping UItableView UITableViewDelegate , UITableViewDataSource , UITableViewDataSourcePrefetching
    func setDataSource(_ dataSource:DataSource?){
        guard let dataSource = dataSource else {return}
        self.dataSource = dataSource
        self.delegate = dataSource
    }
    
}

