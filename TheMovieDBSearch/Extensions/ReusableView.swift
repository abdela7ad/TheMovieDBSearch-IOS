//
//  ReusableView.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 7/27/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableView {}

protocol ReusableCell:ReusableView {
    
}
extension ReusableCell {
    
    static var reuseID :String{
        return String(describing: self)
    }
    
    static var nib:UINib{
        return UINib(nibName: reuseID, bundle: nil)
    }
}
extension UITableViewCell:ReusableCell {}

