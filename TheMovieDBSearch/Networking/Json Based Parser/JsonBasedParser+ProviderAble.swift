//
//  JsonProvider.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 8/1/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation
import Moya



/// Json base provider that can parse 
struct JsonBasedParser :ProvidAble{
 
    
    private(set) var provider = MoyaProvider<MovieDBAPI>(plugins: [NetworkLoggerPlugin(verbose: true),CachePolicyPlugin()], trackInflights: true)

    
    @discardableResult
    public func request<T: Codable>(_ target: MovieDBAPI,
                                    objectModel: T.Type,
                                    success: ((_ returnData: T) -> ())?, failure: ((_ Error: Error) -> ())?) -> Cancellable? {
        
        
        
        let requestTask = provider.request(target,completion:{
            if let error = $0.error {
                failure?(error)
                
                return
            }
            
            
            do {
                
                guard let data = try $0.value?.map(objectModel.self) else{
                    return
                }
                
                success?(data)
                
            } catch  {
                failure?(MoyaError.jsonMapping($0.value!))
            }
        })
        
        return requestTask
        
    }
    
    
}


final class CachePolicyPlugin: PluginType {
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if let cachePolicyGettable = target as? CachePolicyGettable {
            var mutableRequest = request
            mutableRequest.cachePolicy = cachePolicyGettable.cachePolicy
            return mutableRequest
        }
        
        return request
    }
}

