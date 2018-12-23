//
//  ViewController.swift
//  MoviesFavorite
//
//  Created by Jose Alarcon Chacon on 12/14/18.
//  Copyright © 2018 Jose Alarcon Chacon. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
//    @IBOutlet weak var tableView: UITableView!
    
    let movieAPI = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a89086b4927405c65e442226c571beb6&language=en-US&page=1")
    
    var results = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("the view loaded")
//        tableView.dataSource = self
//        self.tableView.reloadData()
        
            let urlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=a89086b4927405c65e442226c571beb6&language=en-US&page=1"
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    print("attempting to parse json")
                    parseJson(json: data)
                }
            }
   }
    
func parseJson(json: Data) {
     let decoder = JSONDecoder()
    
     if let jsonMovie = try? decoder.decode(Movies.self, from: json) {
        results = jsonMovie.results
        print(results)
        print("parsing movies data!")
       }
    }


//extension ViewController: UITableViewDataSource {
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "movieCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let resulToSet = results[indexPath.row]
        cell.textLabel?.text = resulToSet.title
        return cell
    }
    
override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
//}
}
