//
//  SecondTableViewController.swift
//  MoviesFavorite
//
//  Created by Jose Alarcon Chacon on 12/27/18.
//  Copyright © 2018 Jose Alarcon Chacon. All rights reserved.
//
import Foundation
import UIKit

class SecondTableViewController: UITableViewController {
    
    @IBOutlet var setTableView: UITableView!
   
    var results = [Movie]()
    var movie: Movie!
    var id: Int = 0
    
    let imageBase = "https://image.tmdb.org/t/p/w500"
    let api_key = "a89086b4927405c65e442226c571beb6"
    let movieApiBeginning =  "https://api.themoviedb.org/3/movie/"

    override func viewDidLoad() {
        super.viewDidLoad()
        print(id)
        if results.count == 0 {
            self.title = "No similar movies to show"
        }
        
        let idString = String(id)
        let movieAPIString = movieApiBeginning + idString + "/similar?api_key=" + api_key + "&language=en-US&page=1"
        if let movieAPI = URL(string: movieAPIString) {
            if let data = try? Data(contentsOf: movieAPI) {
                print("attempting to parse json")
                parseJSON(json: data)
            }
        }
    }

    func parseJSON(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonMovies = try? decoder.decode(Movies.self, from: json) {
            results = jsonMovies.results
            print(results)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //var movieToSet: Movie
        let cellIdentifier = "similarMovieCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SecondTableViewCell
        let cellResult = results[indexPath.row]
        
        if cellResult.title != nil {
             cell?.titleName.text = cellResult.title
        }

            let backdropString = imageBase + cellResult.backdrop_path
            if let url = URL(string: backdropString) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            cell?.imageMovieView.image = UIImage(data: data)
                        }
                    }
                }
            }
       return cell!
    }
}
