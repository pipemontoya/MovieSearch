//
//  PopularViewModel.swift
//  MovieSearch
//
//  Created by Andres Montoya on 7/30/19.
//  Copyright © 2019 Andres Montoya. All rights reserved.
//

import Foundation

class PopularViewModel{
    
    private(set) var movies = [Movie]()

    func getMovies(_ handler: @escaping (Result<Bool, Error>) -> Void) {
        ApiService.shared.get(popularMovies: { result in
            switch result {
            case .success(let movies):
                self.movies = movies
                handler(.success(true))
            case .failure(let error):
                handler(.failure(error))
            }
        })
    }
}
