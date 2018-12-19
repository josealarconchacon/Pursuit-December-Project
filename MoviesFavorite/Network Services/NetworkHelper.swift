//
//  NetworkHelper.swift
//  MoviesFavorite
//
//  Created by Jose Alarcon Chacon on 12/18/18.
//  Copyright © 2018 Jose Alarcon Chacon. All rights reserved.
//

import Foundation
final class NetworkHelper {
    static func dataTask(urlString: String, httpMethod: String, completionHandler: @escaping (AppError?, Data?, HTTPURLResponse?) ->Void) {
        guard let url = URL.init(string: urlString) else {
            completionHandler(AppError.badURL("\(urlString)"),nil,nil)
            return
        }
        var requestTo = URLRequest(url: url)
        requestTo.httpMethod = httpMethod
        
        URLSession.shared.dataTask(with: requestTo) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                completionHandler(AppError.badData,nil,nil)
                return
            }
            print("the response is: \(response.statusCode)")
            if let error = error {
                completionHandler(AppError.networkError(error),nil,response)
            } else if let data = data {
                completionHandler(nil,data,response)
            }
        }.resume()
    }
}
