//
//  MovieCellViewModel.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 7/31/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation


protocol MovieDisplayable {
    var releaseDateFormatted :String {get}
    var moveTitle :String {get}
    var moviePerview :String? {get}
    var posterURL    :URL? {get}
}

public class MovieCellViewModel :MovieDisplayable {

    private  let dateFormatter = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    private var movie:Movie
    
    init(_ movieItem:Movie) {
        self.movie = movieItem
    }
    
    //MARK :- Internal Helper Methods
    private func dateFromString() -> Date?{
        guard let string = self.movie.releaseDate else { return nil}
        self.dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: string)
    }
    
    private func formatPosterURL() -> URL?{
         return URL(string: "\(Config.POSTERIMAGEURL)\(self.movie.posterPath ?? "")")
    }
    
    
    private var formattedDisplayDate: String {
        if  let date =  dateFromString() {
            
            self.dateFormatter.locale = Locale.current
            self.dateFormatter.dateStyle = .medium
            self.dateFormatter.timeStyle = .none
            return self.dateFormatter.string(from: date)
        }else{
            return String.unknownReleaseDate
        }
    }
    
    
    //MARK:- MovieDisplayable
    var moveTitle: String {
        return movie.title
    }
    
    var moviePerview: String? {
        return movie.overview
    }
    
    var posterURL: URL? {
        return formatPosterURL()
    }
    
    var releaseDateFormatted: String {
        return formattedDisplayDate
    }
    
}


