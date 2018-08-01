//
//  SuggestTableViewCell.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 7/27/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import UIKit

class SuggestTableViewCell: UITableViewCell {
    @IBOutlet weak var movieName : UILabel!

    
    func configure(data: SuggestStorage) {
        self.movieName.text = data.searchQuery
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
