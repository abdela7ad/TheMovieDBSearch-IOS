//
//  Parser.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 8/1/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation
import Moya
import Alamofire


/*  To make our api independent on Parser on Any provider that
 will implement that method will be accpetable to get all API*/

protocol ProvidAble {
   @discardableResult
    
   /// Any parser that implement that method will be able to work  withour api , increase scalability
   ///
   /// - Parameters:
   ///   - target: MovieDBAPI  Target type of Moya
   ///   - objectModel: Object that will model to it
   ///   - success: rerun model dara
   ///   - failure: failre with all error possible
   /// - Returns: /// Protocol to define the opaque type returned from a request. implement isCancelled, cancel() the request
   func request<T: Codable>(_ target: MovieDBAPI,objectModel: T.Type,success: ((_ returnData: T) -> ())?, failure: ((_ Error: Error) -> ())?) -> Cancellable?
}

