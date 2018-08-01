//
//  TheMovieDB.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 7/26/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation
import Moya


 enum MovieDBAPI {
    case search(query:String ,page:Int)
}

/// to enable us to set cache policy

protocol CachePolicyGettable {
    var cachePolicy: URLRequest.CachePolicy { get }
}


extension MovieDBAPI:TargetType,CachePolicyGettable {
    var cachePolicy: URLRequest.CachePolicy {
        return URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
    }
    
    var baseURL: URL {
        // if Base URL can't read Crash
        guard let url =  URL(string: Config.BASEURL) else { fatalError("Check your api baseUrl") }
        return url
    }
    var path: String {
        
        switch self {
            
        case .search:
            return "/search/movie"
        }
    }
    
    var method: Moya.Method  {
        switch self {
        case .search:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case  .search:
            return  subbedResonse("SearchResponse")
        }
    }
    
    var task: Task {
        switch self {
        case let .search(query,page):
            return .requestParameters(parameters: ["api_key" : Config.APIKEY , "query":query,"page":page], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Accept": "application/json"]
    }
    
    var validationType: ValidationType{
        return .successCodes
    }
}

/// for testing read json from file
func subbedResonse(_ fileName:String) -> Data{
    @objc class TestClass :NSObject {}
    let  bundle = Bundle(for:TestClass.self)
    let pathUrl = bundle.url(forResource: fileName, withExtension: "json")
    return try! Data.init(contentsOf: pathUrl!)
}
