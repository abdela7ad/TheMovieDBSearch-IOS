//
//  ResultsViewModel.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 7/29/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
/// View Model for ResultViewController
class ResultsViewModel {
    
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
    
   
    
    private var pager = MoviePaging()
    
    /* used when loading more we just scroll table view to bootom to
          make sure that loading indicator is seen for user  in visibale area*/
    var visibleRect = CGRect.zero

    
    internal var movies = [MovieDisplayable]()
    
    /// Injection dependency on Network API service
    private let movieClient  = MovieDBProvider()
    
    /// Injection dependency on CoreDataPersistence service
    private let persistence = CoreDataPersistance()
    
    
    /// Data Source that handel switch between View State According to selected index
    private(set) var dataSourceAdapter = ResultStatesDataSource()
    
    /// trigger cloure that dataSource state Changed
    var didChangeDataSourceState = {() in}
    /// trigger cloure that dataSource state Changed
    /// Bool  if true  then refresh if false then display message
    var didTriggetLoadMoreState : (Bool) -> Void = {(_) in}

  

    // selected index for datasource from segmented Datasource
    var selectedIndex:State = .suggest {
        didSet{
            dataSourceAdapter.selectedDataSourceIndex = selectedIndex.rawValue
            didChangeDataSourceState() // to reload table
        }
    }
    
    /// for paging
    var page: Int {
        return pager.page
    }
    var searchQuery:String = "" {
        didSet{
            self.pager = MoviePaging()
        }
    }
    
    init() {
        listenForReachability()
    }
    
  
    
    /// ResultViewSourceViewState   to manage stata and map to diffrent Data Source
    var resultsViewState:ResultViewDataSourceState = .suggest([SuggestStorage]()) {
        
        didSet {
            switch resultsViewState {
                
            case let .results(movieDisplays):
                
                dataSourceAdapter.resultDataSource.items = movieDisplays
                selectedIndex = .ready
                
            case let .suggest(suggestStorages):
                
                dataSourceAdapter.suggestedDataSource.items = suggestStorages
                selectedIndex = .suggest

            case let .error(searchAlertableError):
                
                dataSourceAdapter.errorDataSource.items = [searchAlertableError]
                selectedIndex = .error

            case .loading:
                dataSourceAdapter.selectedDataSourceIndex = State.loading.rawValue
                selectedIndex = .loading

            case let .loadingMore(isRefreshState):
                didTriggetLoadMoreState(isRefreshState)
            }
        }
        
    }
    
    // listenForReachability
    func listenForReachability() {
        self.reachabilityManager?.listener = { status in
            print("Network Status Changed: \(status)")
            switch status {
            case .notReachable:
                self.resultsViewState =  .error(SearchMoviesError.network(NetworkError.noInternetConnection))
            case .reachable, .unknown:
               self.fetchMovies()
            }
        }
        
        self.reachabilityManager?.startListening()
    }
    
    
    /// handle Scroll DidEndDecelerating to load More Data
    func scrollViewDidEndDecelerating(_ configure:@escaping (()->Void)){
        dataSourceAdapter.resultDataSource.configureCrollViewDidEndDecelerating {
            configure()
        }
    }
    
    /// usr didSelect suggested item ready by Search View to activate searchbar
    public func selectionHanlder(_ handler:@escaping SelectBlock){
        dataSourceAdapter.suggestedDataSource.selectionHanlder { (suggest, indexPath) in
            handler(suggest,indexPath)
        }
    }
    
    
    
    /// calculate  if user is dragging at bottomEdge of scrollView of table or not
    ///
    /// - Parameters:
    ///   - contentOffset: of tableView
    ///   - boundSiz: of tableView
    ///   - contentSize: of tableView
    ///   - frame: of tableView
    func calculateForLoadMoreReady( with contentOffset:CGPoint ,
                                       boundSiz:CGSize , contentSize:CGSize ,frame:CGRect) {
        
        var visibleRect = CGRect()
        visibleRect.origin = contentOffset
        visibleRect.size = boundSiz
        

        /* check for offset y + frame hieght to know if it at end or not
         also contentSize.height >= frame.height in case result is small , that will pass first condition bottomEdge >= contentSize.height
        */
        
        let bottomEdge = contentOffset.y + frame.size.height
        if bottomEdge >= contentSize.height  && contentSize.height >= frame.height{
            // get more space to allow indicator to seen to user by calculate window?.safeAreaInsets.bottom
            let window = UIApplication.shared.keyWindow
            self.visibleRect = visibleRect
            if #available(iOS 11.0, *) {
                self.visibleRect.size.height = self.visibleRect.size.height + (window?.safeAreaInsets.bottom ?? 0)
            } else {
                // Fallback on earlier versions
            }

            /// start fetch  movies and at this method will check on paging and so on 
            fetchMovies()
        }
        
    }
    
    
    
    //MARK:- persistence Methods
    
    /// Load stored suggestion using filter search
    func loadSuggested(){
        // load suggest with filter
        var  predicate : NSPredicate?
        if !searchQuery.isEmpty {
            predicate = NSPredicate(format: "searchQuery CONTAINS[cd] %@", searchQuery)
        }
        let results = getSuggested(predicate)
        
    
        if checkConnectivity() {
            // change result view state
            resultsViewState = .suggest(results)
        }
   
    }
    
    
    /// gets stored suggested data
    ///
    /// - Parameter predicate: filter predicate with name
    /// - Returns: return SuggestStorage array
    private func getSuggested(_ predicate:NSPredicate? = nil) -> [SuggestStorage]{
        let sort = NSSortDescriptor(keyPath: \SuggestStorage.searchQueryDate, ascending: false)
        return persistence.fetch(SuggestStorage.self, predicate: predicate, sorted: sort)
    }
    
    
    
    //MARK:- Fetch Methods

    func fetchMovies() {
        
        /// check if there is more result if no don't fetch
        guard checkForMoreResults() else {return}
        
        // Enter Loading State  loading or loading more
        runLoadingState()
        
        // Start fetching
        self.movieClient.getMovies(searchQuery: self.searchQuery, page: page)
        { (movies, paging,error) in
            
            // check Network error
            guard self.checkNetwrokErrorStateReady(error) else{ return }
            
            /// update pager value with new one after request
            self.updatePage(afterFetch: movies, pager: paging)
            
            // chek for result state even ready or  no result
            if self.checkSearchResultState(paging, resultMovies: movies) {
                /// if  have result save new  query
                self.persistQuery()
            }
            // upadte pager with new value
            self.pager.page =  self.pager.page + 1

        }
    }
    
    
    /// set loading state
    ///
    /// - Parameter pageing: page to load
    private func runLoadingState(){
        // if page == 1   it will be first load else will be more
        if page == 1 {
            self.resultsViewState = .loading
        }else{
            self.resultsViewState = .loadingMore(true)
        }
    }
    
    /// check for  more paging
    ///
    /// - Parameter pageing: current paging that will be fetch
    /// - Returns: Bool to check to fetch or not
    private func checkForMoreResults() -> Bool{
        
        if  page <= pager.totalPages  {
            return true
        }else{
            self.resultsViewState = .loadingMore(false)

            return false
        }
      
    }
    
    func checkNetwrokErrorStateReady(_ error:AlertableError?) -> Bool {
        if  let error = error {
            self.resultsViewState = .error(.network(error))
            self.movies = [MovieDisplayable]()
            return false
        }
        return true
    }
    
    
    func updatePage(afterFetch movies : [MovieDisplayable] , pager: MoviePaging){
        // update paging
        self.pager = pager
        // check for  paging 1 new search else append to old
        if page == 1 {
            self.movies = movies
        }else{
            self.movies.append(contentsOf: movies)
        }
    }
    
    
    /// check search result state to be  no result or ready state
    @discardableResult
    private func checkSearchResultState(_ pageing:MoviePaging  , resultMovies movies:[MovieDisplayable]) -> Bool{
        
        if pageing.page == 1 &&  movies.count == 0{
            /// Error State
            self.resultsViewState = .error(.noResult)
            return false
        }else {
            self.resultsViewState = .results(self.movies)
            return true
        }
    }
    
    
    private func persistQuery(){
        // save Suggest
        do {
            try saveSuggest()
        } catch  {
            print(error.localizedDescription)
        }
    }
   
    private func saveSuggest() throws{
        
        let objectToSave = try persistence.create(SuggestStorage.self)
        objectToSave.searchQuery = searchQuery
        objectToSave.searchQueryDate = Date().timeIntervalSince1970
        try persistence.save(object: objectToSave)
    }
    
    @discardableResult
    func checkConnectivity() -> Bool{
        if !Connectivity.isConnectedToInternet() {
             resultsViewState =  .error(SearchMoviesError.network(NetworkError.noInternetConnection))
            return false
        }
        return true
    }
   
    
}
