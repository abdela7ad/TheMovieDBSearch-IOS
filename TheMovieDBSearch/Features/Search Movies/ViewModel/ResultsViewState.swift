//
//  ResultsViewState.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 7/31/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation



/// Index for State fo resultView that have tableview with 4 diffrent dataSource
///
/// - suggest: suggest Datasource index 0
/// - loading: loading Datasource index 1
/// - error: error Datasource index 2
/// - ready: ready(results) Datasource index 3
/// - loadMore: load just we use footerview of table
enum State:Int{
    case suggest  = 0
    case loading  = 1
    case error    = 2
    case ready    = 3
    case loadMore = 4
}


/// Result View Model DataSource State
///
/// - results: load data source with search results
/// - suggest: load data source with suggest results
/// - error:  display error SearchMoviesError , Netwrok error
/// - loading: dataousrce in loading state
/// - loadingMore: loading more state   Bool indicate to refresh or  no more message

enum ResultViewSourceViewState {
    case results([MovieDisplayable])
    case suggest([SuggestStorage])
    case error (SearchMoviesError)
    case loading
    case loadingMore(Bool)
}

