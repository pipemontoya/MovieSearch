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
    
    private let baseUrl = "https://api.themoviedb.org/3"
    private let apiKey = "e5585fb8adb87a42bd8e55d4c76c8e46"
    static let shared = ApiService()
    public typealias RequestHandler = (Swift.Result<[Movie], Error>) -> Void
    public typealias RequestVideoHandler = (Swift.Result<[Video], Error>) -> Void

    
    enum ApiErrors: Error {
        case serverError, emptyData
    }
    
    func get(popularMovies handler: @escaping RequestHandler) {
        var users = [Movie]()
        let url = URL(string: "\(baseUrl)/movie/popular?api_key=\(apiKey)")
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
    
    func get(topRatedMovies handler: @escaping RequestHandler) {
        var users = [Movie]()
        let url = URL(string: "\(baseUrl)/movie/top_rated?api_key=\(apiKey)")
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.requestCachePolicy = NSURLRequest.CachePolicy.returnCacheDataElseLoad
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url!) {(data, response, error) in
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
    func get(UpcomingMovies handler: @escaping RequestHandler) {
        var users = [Movie]()
        let url = URL(string: "\(baseUrl)/movie/upcoming?api_key=\(apiKey)")
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.requestCachePolicy = NSURLRequest.CachePolicy.returnCacheDataElseLoad
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url!) {(data, response, error) in
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
    func get(videos movieId: Int, handler: @escaping RequestVideoHandler ) {
        var videos = [Video]()
        let url = URL(string: "\(baseUrl)/movie/\(movieId)/videos?api_key=\(apiKey)")
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.requestCachePolicy = NSURLRequest.CachePolicy.returnCacheDataElseLoad
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url!) {(data, response, error) in
            guard error == nil else {
                handler(.failure(ApiErrors.serverError))
                return
            }
            guard let content = data else {
                handler(.failure(ApiErrors.emptyData))
                return
            }
            let json = JSON(content)
            for video in json["results"].arrayValue {
                videos.append(Video(json: video))
            }
            handler(.success(videos))
        }
        task.resume()
    }
    func getMovies(by name: String, handler: @escaping RequestHandler ) {
        var movies = [Movie]()
        let originalString = "\(baseUrl)/search/movie/?api_key=\(apiKey)&language=en-US&query=\(name.lowercased())&page=1&include_adult=false"
        let urlEncoded = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: urlEncoded)
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.requestCachePolicy = NSURLRequest.CachePolicy.returnCacheDataElseLoad
        let session = URLSession(configuration: config)
        guard let URL = url else {return}
        let task = session.dataTask(with: URL) {(data, response, error) in
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
                movies.append(Movie(JSON: movie))
            }
            handler(.success(movies))
        }
        task.resume()
    }
}
