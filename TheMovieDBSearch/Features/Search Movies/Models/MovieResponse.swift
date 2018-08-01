//
//  MovieResponse.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 7/26/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation

public struct MovieResponse: Codable {
    let page, totalResults, totalPages: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
}


extension MovieResponse {
    init(data: Data) throws {
        self = try JSONDecoder().decode(MovieResponse.self, from: data)
    }
}
struct Movie: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let overview, releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case  overview
        case releaseDate = "release_date"
    }
}
