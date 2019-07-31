//
//  Movie.swift
//  MovieSearch
//
//  Created by Andres Montoya on 7/30/19.
//  Copyright © 2019 Andres Montoya. All rights reserved.
//

import Foundation
import SwiftyJSON
import Kingfisher

class Movie: NSObject {
    var voteAverage: Double
    var voteCount: Int
    var id: Int
    var video: Bool
    var mediaType: String
    var title: String
    var popularity: Double
    var poster: String
    var imageUrl: String {
        get {
            return "https://image.tmdb.org/t/p/w500\(poster)"
        }
    }
    var lenguage: String
    var originalTitle: String
    //var genreId: [Int]
    var backDropPath: String
    var adult: Bool
    var overview: String
    var releaseDate: String
    
    init(JSON: JSON) {
        self.voteAverage = JSON["vote_average"].doubleValue
        self.voteCount = JSON["vote_count"].intValue
        self.id = JSON["id"].intValue
        self.video = JSON["video"].boolValue
        self.mediaType = JSON["media_type"].stringValue
        self.title = JSON["title"].stringValue
        self.popularity = JSON["popularity"].doubleValue
        self.poster = JSON["poster_path"].stringValue
        self.lenguage = JSON["original_language"].stringValue
        self.originalTitle = JSON["original_title"].stringValue
        //self.genreId = JSON[].arrayValue
        self.backDropPath = JSON["backdrop_path"].stringValue
        self.adult = JSON["adult"].boolValue
        self.overview = JSON["overview"].stringValue
        self.releaseDate = JSON["release_date"].stringValue
    }
    
}
