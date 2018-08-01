//
//  UIImageview+Loading.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 7/27/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    func lazyLoading(from url:URL?){
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url)
    }
}
