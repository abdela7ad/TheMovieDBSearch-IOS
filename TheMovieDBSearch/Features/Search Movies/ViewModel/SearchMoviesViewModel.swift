//
//  SearchMoviesViewModel.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 7/26/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation
import Moya
import Alamofire




final class SearchMoviesViewModel {

    var recentSearchHandler: (([SuggestStorage])->Void) = {_ in}

    /// Injection dependency on CoreDataPersistence service
    private let persistence = CoreDataPersistance()
    
}
    

extension SearchMoviesViewModel {

    func loadRecentSuggested(){
        let sort = NSSortDescriptor(keyPath: \SuggestStorage.searchQueryDate, ascending: false)
        let results = persistence.fetch(SuggestStorage.self, predicate: nil, sorted: sort)
        recentSearchHandler(results)
    }
}

