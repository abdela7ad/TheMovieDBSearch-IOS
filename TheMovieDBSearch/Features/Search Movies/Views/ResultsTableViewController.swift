//
//  SearchResultsTableViewController.swift
//  DataSource
//
//  Created by Abdelahad on 7/28/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import UIKit



class ResultsTableViewController: UITableViewController {

    
    let viewModel =  ResultsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register Cell that represent State
        self.tableView.register(nibCell: MovieTableViewCell.self)
        self.tableView.register(nibCell: SuggestTableViewCell.self)
        self.tableView.register(nibCell: ErrorTableViewCell.self)
        self.tableView.register(nibCell: LoadingTableViewCell.self)

        // check UItableView+Extensions
        self.tableView.setDataSource(viewModel.dataSourceAdapter)
        
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none

        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.checkConnectivity()
    }
    func bindViewModel(){
        
        /// reload data according to change DataSource State
        viewModel.didChangeDataSourceState = { [weak self]() in
            guard let strongSelf = self else { return }
            
            
            // reset content size after switch between dataource
            strongSelf.tableView.contentSize  =  strongSelf.tableView.frame.size
            strongSelf.tableView.reloadData()
            strongSelf.tableView.tableFooterView = UIView()

        }
        
        // Load more
        viewModel.didTriggetLoadMoreState = { [weak self] (isRefreshState) in
            guard let strongSelf = self else { return }
    
            let moreView = LoadingMoreView.loadFromXib()
            if isRefreshState {
                moreView.messageLabel.isHidden = true
                moreView.indicator.isHidden = false

            }else{
                moreView.messageLabel.isHidden = false
                moreView.indicator.isHidden = true
            }
            
            strongSelf.tableView.tableFooterView = moreView
            
            strongSelf.tableView.scrollRectToVisible(strongSelf.viewModel.visibleRect, animated: true)
        }
        
        viewModel.scrollViewDidEndDecelerating {
            
            self.viewModel.calculateForLoadMoreReady(with: self.tableView.contentOffset, boundSiz: self.tableView.bounds.size, contentSize: self.tableView.contentSize, frame: self.tableView.frame)
    
        }
    }
}


