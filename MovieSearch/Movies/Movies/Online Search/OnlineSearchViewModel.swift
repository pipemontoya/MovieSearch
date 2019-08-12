//
//  OnlineSearchViewModel.swift
//  MovieSearch
//
//  Created by Andres Montoya on 8/11/19.
//  Copyright © 2019 Andres Montoya. All rights reserved.
//

import Foundation

class OnlineSearchViewModel {
    private(set) var movies = [Movie]()
    func getMovies(by name: String, handler: @escaping (([Movie]) -> Void)) {
        ApiService.shared.getMovies(by: name) { (result) in
            self.movies = []
            switch result {
            case .success(let movies):
                self.movies = movies
                handler(movies)
            case .failure(let error):
                print(error)
            }
        }
    }
}
