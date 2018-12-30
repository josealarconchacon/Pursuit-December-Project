//
//  SecondTableViewCell.swift
//  MoviesFavorite
//
//  Created by Jose Alarcon Chacon on 12/27/18.
//  Copyright © 2018 Jose Alarcon Chacon. All rights reserved.
//

import UIKit

class SecondTableViewCell: UITableViewCell {
    @IBOutlet weak var imageMovieView: UIImageView!
    @IBOutlet weak var titleName: UILabel!
    
    var similaerMovies = [Movie]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
