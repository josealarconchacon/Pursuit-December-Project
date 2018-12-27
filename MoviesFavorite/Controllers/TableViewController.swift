//
//  ViewController.swift
//  MoviesFavorite
//
//  Created by Jose Alarcon Chacon on 12/14/18.
//  Copyright © 2018 Jose Alarcon Chacon. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
   // @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    let movieAPI = URL.init(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a89086b4927405c65e442226c571beb6&language=en-US&page=1")
    let imagesBaseUrlString = "https://image.tmdb.org/t/p/w500"
    
    var results = [Movie]()
    //1 (Array of movies filtered by search term)
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
        // 4
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a movie"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController

          tableView.dataSource = self
          self.tableView.reloadData()
        
        let urlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=a89086b4927405c65e442226c571beb6&language=en-US&page=1"
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                print("attempting to parse json")
                parseJson(json: data)
            }
        }
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let detailViewController = segue.destination as? DetailViewController
        let indexPath = tableView.indexPathForSelectedRow
        let selectedMovie = results[indexPath!.row]
        let movie = filter() ? filteredMovies[indexPath!.row]: results[indexPath!.row]
        detailViewController?.selectedMovie = movie
    }
    
    func parseJson(json: Data) {
        let decoder = JSONDecoder()
    
    if let jsonMovie = try? decoder.decode(Movies.self, from: json) {
        results = jsonMovie.results
        print(results)
        print("parsing movies data!")
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
    
//        var movieToSet = sortWhenSearching[indexPath.row]
        var movieToSet: Movie
        
        if filter() {
            movieToSet = filteredMovies[indexPath.row]
        } else {
            movieToSet = results[indexPath.row]
        }
    
        let cellIdentifier = "movieCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieTableViewCell
        let resulToSet = results[indexPath.row]
//        cell?.movieNameLabel.text = resulToSet.title
        cell?.movieNameLabel.text = movieToSet.title
    
//        let backdropUrlString = imagesBaseUrlString + resulToSet.backdrop_path
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
//extension TableViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.resignFirstResponder()
//        guard let seachText = searchBar.text,
//        !seachText.isEmpty,
//            let searchTextEncode = seachText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
//                return
//        }
//    }
//}
extension TableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
