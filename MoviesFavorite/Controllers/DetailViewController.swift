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
    
    var selectedMovie: Movie?
    
    let imageBaseUrlString = "https://image.tmdb.org/t/p/w500"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSetUp()
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
