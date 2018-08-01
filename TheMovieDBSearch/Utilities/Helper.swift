//
//  Helper.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 7/31/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation
import UIKit

// general function to get padding of save area

func windowPadding() -> CGFloat{
    var padding :CGFloat = 0
    if #available(iOS 11.0, *) {
        let window = UIApplication.shared.keyWindow
        let topPadding = window?.safeAreaInsets.top ?? 0
        let bottomPadding = window?.safeAreaInsets.bottom ?? 0
        print(topPadding,bottomPadding)
        padding = topPadding + bottomPadding
    }
    return padding
}



