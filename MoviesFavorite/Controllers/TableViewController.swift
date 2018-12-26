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
    
    
    let movieAPI = URL.init(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=&language=en-US&page=1")
    let imagesBaseUrlString = "https://image.tmdb.org/t/p/w500"
    
    
    var results = [Movie]()
    //var movieToFilter = [Movie]()
    //var sortWhenSearching = [Movie]()
    
    // setting the search bar
    //let searchController = UISearchController(searchResultsController: nil)
    
//    func searchIsEmpty() -> Bool {
//        return searchController.searchBar.text?.isEmpty ?? true
//    }
//    func filterContentForSearchText(_ searchText: String, scope: String = "ALL") {
//        movieToFilter = results.filter({( user : Movie) -> Bool in
//            let value = user.title.contains(searchText.lowercased())
//        return value
//        })
//        tableView.reloadData()
//    }
//    func filter() -> Bool {
//        return !searchIsEmpty()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("the view loaded")
//        definesPresentationContext = true
//        searchController.searchResultsUpdater = self
//        searchController.searchBar.placeholder = "earch for a movie"
//        searchController.obscuresBackgroundDuringPresentation = false
//        navigationItem.searchController = searchController
        
//        tableView.dataSource = self
//        self.tableView.reloadData()
        
        let urlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=&language=en-US&page=1"
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                print("attempting to parse json")
                parseJson(json: data)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let indexPath = tableView.indexPathForSelectedRow,
//        let description = segue.destination as? DetailViewController else { return}
//        let setUpResult = results[indexPath.row]
        super.prepare(for: segue, sender: sender)
        let detailViewController = segue.destination as? DetailViewController
        let selectedCell = sender as? MovieTableViewCell
        let indexPath = tableView.indexPathForSelectedRow
        let selectedMovie = results[indexPath!.row]
        detailViewController?.selectedMovie = selectedMovie
        
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
//    if filter() {
//        return movieToFilter.count
//    }
        return results.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //sortWhenSearching  = movieToFilter.sorted(by: { $0.title < $1.title})
    
//    var movieToSet = sortWhenSearching[indexPath.row]
//    if filter() {
//        movieToSet = movieToFilter[indexPath.row]
//    } else {
//        movieToSet = results[indexPath.row]
//    }
    
        let cellIdentifier = "movieCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieTableViewCell
        let resulToSet = results[indexPath.row]
        cell?.movieNameLabel.text = resulToSet.title
        
    
        let backdropUrlString = imagesBaseUrlString + resulToSet.backdrop_path
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
//    extension CGImage {
//        var imageIsDark: Bool {
//            get {
//                guard let imageData = self.dataProvider?.data else { return false}
//                guard let pt = CFDataGetBytePtr(imageData)  else { return false}
//                let theLength = CFDataGetLength(imageData)
//                let toSet = Int(Double(self.width * self.height) * 0.45)
//                var darkPixels = 0
//                for i in stride(from: 0, to: theLength, by: 4) {
//                    let r = pt[i]
//                    let g = pt[i + 1]
//                    let b = pt[i + 2]
//                    let luminance = (0.299 * Double(r) + 0.587 * Double(g) + 0.114 * Double(b))
//                    if luminance < 150 {
//                        darkPixels += 1
//                        if darkPixels > toSet {
//                            return true
//                        }
//                    }
//                }
//                return false
//            }
//        }
//}
//
//
//extension UIImage {
//    var isDark: Bool {
//        get {
//            return self.cgImage?.isMask ?? false
//        }
//    }
//}





