//
//  XibLoadable.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 7/31/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation
import  UIKit
protocol XibLoadable {
    associatedtype CustomViewType
    static func loadFromXib() -> CustomViewType
}

extension XibLoadable where Self: UIView {
    static func loadFromXib() -> Self {
        let nib = UINib(nibName: "\(self)", bundle: Bundle.main)
        guard let customView = nib.instantiate(withOwner: self, options: nil).first as? Self else {
            // your app should crash if the xib doesn't exist
            preconditionFailure("Couldn't load xib for view: \(self)")
        }
        return customView
    }
}
