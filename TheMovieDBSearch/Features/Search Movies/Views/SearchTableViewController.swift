//
//  SearchTableViewController.swift
//  DataSource
//
//  Created by Abdelahad on 7/28/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//


import UIKit

class SearchTableViewController: UITableViewController {
    
    private(set) var searchViewModel = SearchMoviesViewModel()

    private(set) var dataSource:SearchDataSource?
    
    /// Secondary search results table view.
    var resultsTableController: ResultsTableViewController!
    
    lazy var searchController = UISearchController(searchResultsController: resultsTableController)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //remove line in smart way
        tableView.tableFooterView = UIView()
        
        // create ResultsTableViewController
        resultsTableController = ResultsTableViewController()
        
       
        tableView.register(nibCell: RecentTableViewCell.self)
        
        // configure data source
        dataSource = SearchDataSource(configureBlock: { (cell, suggest, indexPath) in
            cell.suggest = suggest
        })
        
        // configure selection process
        dataSource?.selectionHanlder({ [weak self] (suggest, indexPath) in
            guard let  stongSelf = self else { return }
            stongSelf.activateSearch(with: suggest)
        })
        

        
      
        
        // set table view to outsourcing data source
        tableView.setDataSource(dataSource)
      
    
        setupSubViews()
        
        // bind View Model to ViewController
        bindViewModel()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /* trigger load searchViewModel.loadRecentSuggested*/
        searchViewModel.loadRecentSuggested()
    }
     func bindViewModel () {
        // recent item to display in tableView
        searchViewModel.recentSearchHandler = { [weak self] (suggests) in
            guard let  stongSelf = self else { return }
            stongSelf.dataSource?.items = suggests
            stongSelf.tableView.reloadData()
        }
        
        let resutlViewModel = resultsTableController.viewModel
        
        resutlViewModel.selectionHanlder { [weak self] (suggest, indexPath) in
             guard let  stongSelf = self else { return }
            stongSelf.activateSearch(with: suggest)
        }
        
    }
    
    
    
    func setupSubViews() {
        
 
        // set title with localized string
        
        navigationItem.title = String.searchMovies
        
        // set up UISearchController
        searchController = UISearchController(searchResultsController: resultsTableController)
        searchController.searchBar.sizeToFit()
        
        
        searchController.searchBar.placeholder = String.searchPlaceholder
        searchController.delegate = self
        if #available(iOS 11.0, *) {
            // For iOS 11 and later, we place the search bar in the navigation bar.
            navigationController?.navigationBar.prefersLargeTitles = true
            
            navigationItem.searchController = searchController
            
            // We want the search bar visible all the time.
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            // For iOS 10 and earlier, we place the search bar in the table view's header.
            tableView.tableHeaderView = searchController.searchBar
        }
        
        searchController.dimsBackgroundDuringPresentation = true // default is YES
        searchController.searchBar.delegate = self    // so we can monitor text changes + others
        
        /*
         Search is now just presenting a view controller. As such, normal view controller
         presentation semantics apply. Namely that presentation will walk up the view controller
         hierarchy until it finds the root view controller or one that defines a presentation context.
         */
        definesPresentationContext = true
    }

    
    private func activateSearch(with suggest:SuggestStorage){
        self.searchController.isActive = true
        self.searchController.searchBar.text = suggest.searchQuery
        self.resultsTableController.viewModel.searchQuery = suggest.searchQuery
        self.resultsTableController.viewModel.fetchMovies()
         self.searchController.searchBar.resignFirstResponder()
    }

}

// MARK: - UISearchBarDelegate

extension SearchTableViewController: UISearchBarDelegate ,UISearchControllerDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        resultsTableController.viewModel.fetchMovies()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        resultsTableController.viewModel.searchQuery = searchText
        resultsTableController.viewModel.loadSuggested()
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        // on dismiss search load Recent 10 items
        searchViewModel.loadRecentSuggested()
    }
}

