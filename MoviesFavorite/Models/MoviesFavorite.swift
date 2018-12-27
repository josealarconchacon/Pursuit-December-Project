//
//  MoviesFavorite.swift
//  MoviesFavorite
//
//  Created by Jose Alarcon Chacon on 12/14/18.
//  Copyright © 2018 Jose Alarcon Chacon. All rights reserved.
//

import Foundation
//import UIKit

struct Movie: Codable {
    var title: String
    var overview: String
    var vote_average: Double
    var backdrop_path: String
    var poster_path: String
    var release_date: String
}
struct Movies: Codable {
    var results: [Movie]
}

