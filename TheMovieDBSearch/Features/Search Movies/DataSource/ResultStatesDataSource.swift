//
//  SearchStateSegmentedDataSource.swift
//  DataSource
//
//  Created by Abdelahad on 7/28/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation
import UIKit


typealias SelectBlock = (SuggestStorage,IndexPath)->Void




final class ResultStatesDataSource: SegmentedDataSource {
    
    var  resultDataSource         = ResultsDataSource()
    var  suggestedDataSource      = SuggestDataSource()
    var  errorDataSource          = ErrorsDataSource()
    var  loadingDataSource        = LoadingDataSource()

    override init() {
        super.init()
        
        errorDataSource.items = [.none]
        loadingDataSource.items = [Void()]

        add(suggestedDataSource)
        add(loadingDataSource)
        add(errorDataSource)
        add(resultDataSource)

    }
}




final class LoadingDataSource: BasicDataSource<LoadingTableViewCell,Void> {
    
    /// padding size to disable Displayable Views (loading, error)
    /// Inset area + statusBarFrame Height
    // used to calculate cell height to be for frame of tableView that disable scroll content size
    var padding :CGFloat {
        return  windowPadding() + UIApplication.shared.statusBarFrame.size.height
    }
    
    // Not selected just for display
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height - padding
    }
}


final class SuggestDataSource: BasicDataSource<SuggestTableViewCell,SuggestStorage> {
    
    private var didSelect: SelectBlock = {_,_  in}
    
    override func configureTableView(_ tableView: UITableView, configure cell: SuggestTableViewCell, with item: SuggestStorage, at indexPath: IndexPath) {
        cell.configure(data: item)
    }
    
    // To handel selections
    public func selectionHanlder(_ handler:@escaping SelectBlock){
        self.didSelect = handler
    }
    
    // Selection Handler
    override func selectionHanlder(_ tableView: UITableView, cellwith item: SuggestStorage, at indexPath: IndexPath) {
        didSelect(item,indexPath)
    }
}


final class ResultsDataSource: BasicDataSource<MovieTableViewCell,MovieDisplayable> {
    
    typealias PrefetchBlock = (IndexPath?)->Void
    private var prefetchRows : PrefetchBlock = {_ in }
    private var scrollViewDidEndDecelerating = {() in }

    func configurePrefetchRows(_ configureBlock: @escaping PrefetchBlock){
        self.prefetchRows = configureBlock
    }
    
    func configureCrollViewDidEndDecelerating(_ configureBlock: @escaping (() -> Void)){
        self.scrollViewDidEndDecelerating = configureBlock
    }
    
    override func configureTableView(_ tableView: UITableView, configure cell: MovieTableViewCell, with item: MovieDisplayable, at indexPath: IndexPath) {
        cell.bindViewModel(item)
    }

    // to detect refrech more
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       scrollViewDidEndDecelerating()
    }
}


final class ErrorsDataSource: BasicDataSource<ErrorTableViewCell,SearchMoviesError> {
    
    /// padding size to disable Displayable Views (loading, error)
    /// Inset area + statusBarFrame Height
    // used to calculate cell height to be for frame of tableView that disable scroll content size
    var padding :CGFloat {
        return  windowPadding() + UIApplication.shared.statusBarFrame.size.height
    }
    override func configureTableView(_ tableView: UITableView, configure cell: ErrorTableViewCell, with item: SearchMoviesError, at indexPath: IndexPath) {
        cell.searchMoviesError = item
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
       return tableView.frame.height - padding
    }
    
    // Not selected just for display
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
}

