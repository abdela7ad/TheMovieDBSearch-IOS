//
//  MovieTableViewCell.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 7/27/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import UIKit

/*ovie Poster
ii. Movie name
iii. Release date
iv. Full Movie Overview*/


class MovieTableViewCell: UITableViewCell {
    

    @IBOutlet weak var movieName : UILabel!
    @IBOutlet weak var movieReleaseDate : UILabel!
    @IBOutlet weak var movieOverview : UITextView!
    @IBOutlet weak var moviePoster : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        /// Remove padding in UITextView
        movieOverview.textContainerInset = UIEdgeInsets.zero
        movieOverview.textContainer.lineFragmentPadding = 0
    }
    
    
    func bindViewModel(_ item:MovieDisplayable){
        movieName.text = item.moveTitle
        movieOverview.text = item.moviePerview
        movieReleaseDate.text = item.releaseDateFormatted
        moviePoster.lazyLoading(from: item.posterURL) 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
