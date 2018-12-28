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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let secondViewC = segue.destination as? SecondTableViewController
        secondViewC!.id = selectedMovie?.id ?? 0
    }
    
    func alert() {
        let alert = UIAlertController(title: "\(selectedMovie?.title ?? "This movie") will be added to your favorites list", message: "Would you like to see similar movies?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            self.performSegue(withIdentifier: "some_ID", sender: nil)
        }))
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
    @IBAction func alertButton(_ sender: UIButton) {
       alert()
    }
}
