//
//  AppAssets.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 7/29/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation
import UIKit

typealias AppAssets = UIImage.Asset



extension UIImage{
    
    /// All Asset image should be same name as in asset bundle
    enum Asset:String {
        case noResult      = "icon_noresult"
        case noConnection  = "Offline_logo"
        case expireAPI  = "expire"

     
        var image:UIImage{
            return (UIImage(asset: self) ?? UIImage())
        }
        
        // rendered Image to change color
        var renderImage:UIImage{
            return image.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        }
        
    }
    
    convenience init? (asset:Asset){
        self.init(named: asset.rawValue)
    }
    
}

