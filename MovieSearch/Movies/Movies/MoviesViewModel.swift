//
//  PopularViewModel.swift
//  MovieSearch
//
//  Created by Andres Montoya on 7/30/19.
//  Copyright © 2019 Andres Montoya. All rights reserved.
//

import Foundation

class MoviesViewModel {
    let index: Int
    private(set) var movies = [Movie]()
    
    init(index: Int) {
        self.index = index
    }
    
    func getTitle() -> String {
        switch index {
        case 0: return "Popular Movies"
        case 1: return "Top Rated Movies"
        case 2: return "Upcoming Movies"
        default:
            return ""
        }
    }

    func getMovies(_ handler: @escaping (Result<Bool, Error>) -> Void) {
        switch index {
        case 0:
            ApiService.shared.get(popularMovies: { result in
                switch result {
                case .success(let movies):
                    self.movies = movies
                    handler(.success(true))
                case .failure(let error):
                    handler(.failure(error))
                }
            })
        case 1:
            ApiService.shared.get(topRatedMovies: { result in
                switch result {
                case .success(let movies):
                    self.movies = movies
                    handler(.success(true))
                case .failure(let error):
                    handler(.failure(error))
                }
            })
        case 2:
            ApiService.shared.get(UpcomingMovies: { result in
                switch result {
                case .success(let movies):
                    self.movies = movies
                    handler(.success(true))
                case .failure(let error):
                    handler(.failure(error))
                }
            })
        default:
            break
        }
        
    }
}
