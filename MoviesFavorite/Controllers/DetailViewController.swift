//
//  DetailViewController.swift
//  MoviesFavorite
//
//  Created by Jose Alarcon Chacon on 12/23/18.
//  Copyright © 2018 Jose Alarcon Chacon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailViewText: UITextView!
    @IBOutlet weak var labelDate: UILabel!
    
    @IBOutlet weak var favorites: UIButton!
    @IBOutlet weak var noFavorites: UIButton!
    
    
    var selectedMovie: Movie?
    var date: Movie!
    
    let imageBaseUrlString = "https://image.tmdb.org/t/p/w500"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSetUp()
        detailViewText.text = selectedMovie?.overview
        labelDate.text = selectedMovie?.release_date
        labelDate.text = DateFormatter.localizedString(from: Date(), dateStyle: .long, timeStyle: .none)
    }
    
    private func movieSetUp() {
        let backdropUrlString = imageBaseUrlString + (selectedMovie?.poster_path)!
        if let backdropURL = URL(string: backdropUrlString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: backdropURL) {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                        
                    }
                }
            }
        }
    }
}
