//
//  Connectivity.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 8/1/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation
import Foundation
import Alamofire
class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
