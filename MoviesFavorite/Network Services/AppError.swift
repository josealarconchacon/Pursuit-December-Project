//
//  AppError.swift
//  MoviesFavorite
//
//  Created by Jose Alarcon Chacon on 12/18/18.
//  Copyright © 2018 Jose Alarcon Chacon. All rights reserved.
//

import Foundation
enum AppError: Error {
    case badURL(String)
    case networkError(Error)
    case badData
    case badDecoding(Error)
    
    public func errorShowed() -> String {
        switch self {
        case .badURL(let str):
            return "badURL is: \(str)"
        case .networkError(let error):
            return "networkError is: \(error)"
        case .badData:
            return "no network response"
        case .badDecoding(let error):
            return "decoding error is: \(error)"
        }
    }
}
