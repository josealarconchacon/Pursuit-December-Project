//
//  MoviesFavorite.swift
//  MoviesFavorite
//
//  Created by Jose Alarcon Chacon on 12/14/18.
//  Copyright © 2018 Jose Alarcon Chacon. All rights reserved.
//

import Foundation
struct MovieFavoriteData: Codable {
    let results: [MovieFavorite]
}
struct MovieFavorite: Codable {
    let vote_count: Int
    let title: String
    let poster_path: String
    let original_title: String
   
}
















//struct MoviesFavorite: Codable {
//    let Search: [MoviesFavorite]
//
//    struct MoviesFavorite: Codable{
//        let Title: String
//        let Year: String
//        let imdbID: String
//        let Poster: String
//    }
//    let MoviesFavorite: MoviesFavorite
//}
//struct MoviesFavorite: Codable {
//    let Title: String
//    let Year: String
//    let Rated: String
//    let Released: String
//    let Runtime: String
//    let Genre: String
//    let Director: String
//    let Writer: String
//    let Actors: String
//    let Plot: String
//    let Language: String
//    let Country: String
//    let Awards: String
//    // this is a limk
//    let Poster: String
//
//    struct Ratings: Codable {
//        let Source: String
//        let Value: String
//    }
//    let Ratings: [Ratings]
//
//    let Metascore: String
//    let imdbRating: String
//    let imdbVotes: String
//    let imdbID: String
//    let DVD: String
//    let BoxOffice: String
//    let Production: String
//    // this is a link
//    let Website: String
//    let Response: Bool
//
//}
