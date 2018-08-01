//
//  ErrorTableViewCell.swift
//  DataSource
//
//  Created by Abdelahad on 7/28/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import UIKit

class ErrorTableViewCell: UITableViewCell {

    @IBOutlet weak var errorMessage : UILabel!
    @IBOutlet weak var errorIcon : UIImageView!
    
    var searchMoviesError : SearchMoviesError?{
        didSet{
            guard let message = searchMoviesError?.localizedMessage else {return }
            self.errorMessage.text = message
            self.errorIcon.image = searchMoviesError?.image
        }
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
