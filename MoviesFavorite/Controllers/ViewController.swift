//
//  ViewController.swift
//  MoviesFavorite
//
//  Created by Jose Alarcon Chacon on 12/14/18.
//  Copyright © 2018 Jose Alarcon Chacon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
  
   private var movie = [MovieFavorite]() {
        didSet {
            DispatchQueue.main.async {
             self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        search(keyword: "ios")
        searchBar.autocapitalizationType = .none
        print(movie)
        
        }
    }
   private func search(keyword: String) {
    MoviesAPIClient.searchMovies(keyword: keyword) { (error, movie) in
        if let error = error {
            print(error.errorShowed())
        }
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        let theCell = movie[indexPath.row]
        cell.textLabel?.text = theCell.original_title
        
        return cell
    }
}

