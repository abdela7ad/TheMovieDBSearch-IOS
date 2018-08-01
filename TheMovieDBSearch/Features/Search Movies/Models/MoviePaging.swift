//
//  MoviePaging.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 7/27/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation

struct MoviePaging {
    var page , totalPages,totalResults : Int
 
    init(_ movieResponse:MovieResponse) {
        self.page = movieResponse.page
        self.totalPages = movieResponse.totalPages
        self.totalResults = movieResponse.totalResults
    }
    
    init() {
        self.page = 1
        self.totalPages = 1
        self.totalResults = 0
    }
}

