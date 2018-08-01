//
//  AutoTableViewCell.swift
//  DataSource
//
//  Created by Abdelahad on 7/28/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import UIKit


extension UIColor {
    
    convenience init(rgb: Int, alphaValue: CGFloat) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(alphaValue)
        )
    }
}
class RecentTableViewCell: UITableViewCell {
   
    @IBOutlet weak var recentQueryLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.recentQueryLabel.textColor = UIColor.init(rgb: 0x1082ff, alphaValue: 1)
    }
    var suggest:SuggestStorage?{
        didSet{
            self.recentQueryLabel.text = suggest?.searchQuery
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
