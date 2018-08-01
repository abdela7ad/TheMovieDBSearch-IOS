//
//  ErrorHandler.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 7/29/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation
import UIKit
import Moya




enum NetworkError:String
{
    case noInternetConnection
    case apiExpire
    case none
}

extension NetworkError : AlertableError {
    var errorModel: ErrorModel {
        switch self {
        case .noInternetConnection:
            return ErrorModel(message:.internetConnection,image:AppAssets.noConnection.image)
        case .apiExpire:
            return ErrorModel(message:.apiExpire,image:AppAssets.expireAPI.image)
        default :
            return ErrorModel.none()
        }
    }

}

enum SearchMoviesError {
    
    case noResult
    case network(AlertableError)
    case none
}

extension SearchMoviesError : AlertableError {
    
    var errorModel: ErrorModel {
        switch self {
        case .noResult:
           return ErrorModel(message:.noSearchResults,image:AppAssets.noResult.image)
        case let .network(networkError):
            return networkError.errorModel
        default :
            return ErrorModel.none()
        }
    }
}
