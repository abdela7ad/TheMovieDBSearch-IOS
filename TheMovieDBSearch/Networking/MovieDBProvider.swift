//
//  TheMovieDBService.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 7/26/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//


import Foundation
import Moya

struct MovieDBProvider{
    
    private(set) var jsonProvider = JsonBasedParser()
    
    /// get movies object on main queue
    ///
    /// - Parameters:
    ///   - page: page number for paging result
    ///   - completion: call back with movies item result will be on main queue
    
    
    public  func getMovies(searchQuery searchInput:String ,  page pageNumber:Int ,  completion:@escaping (([MovieDisplayable],MoviePaging,AlertableError?)->Void)){
        
        jsonProvider.request(.search(query: searchInput, page: pageNumber), objectModel: MovieResponse.self, success: { (movieResponse) in
            let moviePage = MoviePaging(movieResponse)
            let movies = movieResponse.movies
            let moviable : [MovieDisplayable] = movies.map({MovieCellViewModel($0)})
            // formatting Error
            DispatchQueue.main.async {completion(moviable,moviePage,nil)}
        }) { (error) in
            let alertableError = self.mapMoyaError(error)

            DispatchQueue.main.async {completion([MovieDisplayable](),MoviePaging(),alertableError)}

        }
    }
    
    
    /// Map Moya error to displayable error
    ///
    /// - Parameter error: Moya error from API request
    /// - Returns: AlertableError check AlertableError to display for user
    internal func mapMoyaError(_ error:Error) -> AlertableError{
        
        if  let error = error as? MoyaError {
            
            switch error {
            case let .underlying(_, response):
                if response ==  nil {
                    return NetworkError.noInternetConnection
                }else{
                    return NetworkError.apiExpire
                }
            case .encodableMapping,.imageMapping,.jsonMapping,.parameterEncoding,.statusCode,.stringMapping:
                return NetworkError.apiExpire
            default:
                return NetworkError.none
            }
           
        }
        return NetworkError.none
    }
    
    
    
    
}





