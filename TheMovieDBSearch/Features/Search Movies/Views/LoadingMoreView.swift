//
//  LoadingMoreView.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 7/31/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation
import  UIKit
class LoadingMoreView:UIView ,XibLoadable {
    @IBOutlet var indicator:UIActivityIndicatorView!
    @IBOutlet var messageLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUp()
    }
    func setUp(){
        self.messageLabel.text = String.noMoreMoviesToDisplay
        self.indicator.startAnimating()
    }
}
