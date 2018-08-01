//
//  Config.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 7/30/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation

struct  Config {
    
    
    /// Enum to handle Poster size
    internal enum Poster: String {
        
        case small    = "w92"
        case medium   = "w185"
        case large    = "w500"
        case Heigh    = "w780"
        
        // Host of image
        private var host : String{
            return  "http://image.tmdb.org/t/p/"
        }
        
        // final address
        var posterAddress:String{
                return "\(host)/\(self.rawValue)"
        }
    }
    
    
    /* Network  Production ,SandBox Base URL
     same url just for Coding.....
  */
  internal  enum NetworkEnvironment {
        case Production
        case SandBox
        
        var baseURL :String {
            switch self {
            case .Production:
                return "https://api.themoviedb.org/3"
            case .SandBox:
                return "https://api.themoviedb.org/3"
            }
        }
        
    }
    
    
    //Base URL
   static let BASEURL = NetworkEnvironment.Production.baseURL
    
    // API KEy
   static let APIKEY = "2696829a81b1b5827d515ff121700838"
    
    // Poster image size address integration
   static let POSTERIMAGEURL = Poster.medium.posterAddress
    
    // API KEy
    static let fetchLimit = 10  // suggest storage only 10 result for fetch

}
