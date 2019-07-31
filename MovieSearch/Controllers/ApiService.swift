//
//  ApiService.swift
//  MovieSearch
//
//  Created by Andres Montoya on 7/30/19.
//  Copyright © 2019 Andres Montoya. All rights reserved.
//

import Foundation
import SwiftyJSON
import Kingfisher

class ApiService {
    
    static let shared = ApiService()
    
    enum ApiErrors: Error {
        case serverError, emptyData
    }
    
    func get(popularMovies handler: @escaping (Swift.Result<[Movie], Error>) -> Void) {
        var users = [Movie]()
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=e5585fb8adb87a42bd8e55d4c76c8e46&&language=en-US&page=1")
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            guard error == nil else {
                handler(.failure(ApiErrors.serverError))
                return
            }
            guard let content = data else {
                handler(.failure(ApiErrors.emptyData))
                return
            }
            let json = JSON(content)
            for movie in json["results"].arrayValue {
                users.append(Movie(JSON: movie))
            }
            handler(.success(users))
        }
        task.resume()
    }
}
