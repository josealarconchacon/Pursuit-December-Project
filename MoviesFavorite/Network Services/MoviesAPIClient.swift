//
//  MoviesAPIClient.swift
//  MoviesFavorite
//
//  Created by Jose Alarcon Chacon on 12/15/18.
//  Copyright © 2018 Jose Alarcon Chacon. All rights reserved.
//

import Foundation


final class MoviesAPIClient {
    static func searchMovies(keyword: String, completionHandler: @escaping(AppError?,[MovieFavorite]?) -> Void) {
        // endpoint()
        let theURLString = "https://api.themoviedb.org/3/movie/now_playing?api_key=a89086b4927405c65e442226c571beb6&language=en-US&page=1"
        NetworkHelper.dataTask(urlString: theURLString, httpMethod: "GET") { (error,data, response) in
            if let error = error {
                completionHandler(error,nil)
            } else if let data = data {
                do {
                    let dataToSet = try JSONDecoder().decode(MovieFavoriteData.self, from: data)
                    //completionHandler(nil,results)
                } catch {
                    completionHandler(AppError.badDecoding(error),nil)
                }
            }
        }
    }
}
