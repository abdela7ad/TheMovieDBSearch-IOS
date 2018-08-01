//
//  String+Localization.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 7/29/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//
import Foundation

extension String {
    
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
}

//MARK: Search Screen
extension String {
    static let searchMovies = "Search_Movies".localized()
    static let searchPlaceholder = "Search_Placeholder".localized()
    static let recent = "Recent".localized()
    static let unknownReleaseDate = "Unknown".localized()
    static let noMoreMoviesToDisplay = "No_more_movie_to_display".localized()

    
}

