//
//  ViewController.swift
//  MoviesFavorite
//
//  Created by Jose Alarcon Chacon on 12/14/18.
//  Copyright © 2018 Jose Alarcon Chacon. All rights reserved.
//

import UIKit

var nowPlaying = [Movie]()
var favoriteMoviesArray = [Movie]()
var moviesYouMightLike = [Movie]()

class TableViewController: UITableViewController {
    //The view will switch between 'main' (now playing), 'similar' (to a particular movie), 'favorites', and 'suggested'
    var viewName = "main"

    @IBOutlet weak var suggested: UIBarButtonItem!
    @IBOutlet weak var favorites: UIBarButtonItem!
    @IBAction func favoriteMovies(_ sender: UIBarButtonItem) {
        //Change to favorites view if current view is main
        if viewName == "main" {
            resultsPlaceholder = results
            results = favoriteMoviesArray
            tableView.reloadData()
            favorites.title = "Now Playing"
            self.title = "Favorite Movies"
            viewName = "favorites"
            suggested.isEnabled = false
        //Change to main view if current view is favorites
        } else if viewName == "favorites" {
            results = resultsPlaceholder
            tableView.reloadData()
            favorites.title = "Favorites"
            self.title = "Now Playing"
            viewName = "main"
            suggested.isEnabled = true
        } else if viewName == "similar" {
            results = nowPlaying
            tableView.reloadData()
            favorites.title = "Favorites"
            self.title = "Now Playing"
            viewName = "main"
        } else if viewName == "suggested" {
            
        }
    }
    @IBAction func suggestedMoviesAction(_ sender: Any) {
        if viewName == "main" {
            resultsPlaceholder = results
            results = moviesYouMightLike
            tableView.reloadData()
            suggested.title = "Now Playing"
            self.title = "Suggested Movies"
            viewName = "similar"
            favorites.isEnabled = false
            //Change to main view if current view is favorites
        } else if viewName == "favorites" {
            results = resultsPlaceholder
            tableView.reloadData()
            suggested.title = "Suggested"
            self.title = "Suggested Movies"
            viewName = "main"
        } else if viewName == "similar" {
            results = nowPlaying
            tableView.reloadData()
            suggested.title = "Suggested"
            self.title = "Now Playing"
            viewName = "main"
            favorites.isEnabled = true
        }
    }
    
    //1
    let api_key = "a89086b4927405c65e442226c571beb6"
    let movieApiBeginning =  "https://api.themoviedb.org/3/movie/"
    
    let movieAPI = URL.init(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a89086b4927405c65e442226c571beb6&language=en-US&page=1")
    
    let imagesBaseUrlString = "https://image.tmdb.org/t/p/w500"
    
    var results = [Movie]()
    
    //2
    var similarMovies = [Movie]()
    var movie: Movie!
    var id: Int = 0
    
    var resultsPlaceholder = [Movie]()
    // (Array of movies filtered by search term)
    var filteredMovies = [Movie]()
    var sortWhenNotSearching = [Movie]()
    var sortWhenSearching = [Movie]()
    
    // setting the search bar
    let searchController = UISearchController(searchResultsController: nil)
    
    func searchIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredMovies = results.filter({( movie : Movie) -> Bool in
            let value = movie.title.lowercased().contains(searchText.lowercased())
        return value
        })
        tableView.reloadData()
    }
    func filter() -> Bool {
        return !searchIsEmpty()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("the view loaded")
        self.title = "Now Playing"
        
        
        
        // 4
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a movie"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
        if nowPlaying.count == 0 && viewName == "main" {
            getNowPlaying()
        } else if viewName == "similar" {
            getSimilarMovies()
            if results.count == 0 {
                self.title = "No similar movies"
            } else {
                self.title = "Similar movies"
            }
        }
        
        tableView.dataSource = self
        self.tableView.reloadData()

    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let detailViewController = segue.destination as? DetailViewController
        let indexPath = tableView.indexPathForSelectedRow
        let movie = filter() ? filteredMovies[indexPath!.row]: results[indexPath!.row]
        detailViewController?.selectedMovie = movie
    }
    
    func parseJson(json: Data) {
        let decoder = JSONDecoder()
    
        if let jsonMovie = try? decoder.decode(Movies.self, from: json) {
            if viewName == "main" {
                nowPlaying = jsonMovie.results
                results = nowPlaying
            } else if viewName == "similar" {
                similarMovies = jsonMovie.results
                results = similarMovies
                for item in similarMovies {
                    if moviesYouMightLike.contains(item) == false {
                        moviesYouMightLike.append(item)
                    }
                }
            }
        print("parsing movies data!")
       }
    }
    
    func getNowPlaying() {
        let urlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=a89086b4927405c65e442226c571beb6&language=en-US&page=1"
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                print("d to parse json for movies now playing")
                parseJson(json: data)
            }
        }
    }
    
    func getSimilarMovies() {
        let idString = String(id)
        let movieAPIString = movieApiBeginning + idString + "/similar?api_key=" + api_key + "&language=en-US&page=1"
        if let similarMovieAPI = URL(string: movieAPIString) {
            if let data = try? Data(contentsOf: similarMovieAPI) {
                print("attempting to parse json for similar movies")
                parseJson(json: data)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 2
        if filter() {
            print(filteredMovies)
            return filteredMovies.count
        }
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        sortWhenNotSearching = results.sorted(by: { $0.title < $1.title})
        //3
        sortWhenSearching  = filteredMovies.sorted(by: { $0.title < $1.title})
    
        var movieToSet: Movie
        
        if filter() {
            movieToSet = filteredMovies[indexPath.row]
        } else {
            movieToSet = results[indexPath.row]
        }
    
        let cellIdentifier = "movieCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieTableViewCell
        let resulToSet = results[indexPath.row]
        cell?.movieNameLabel.text = movieToSet.title

        let backdropUrlString = imagesBaseUrlString + movieToSet.backdrop_path
        if let bsckdropURL = URL(string: backdropUrlString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: bsckdropURL) {
                    DispatchQueue.main.async {
                        cell?.movieImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        return cell!
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension TableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
