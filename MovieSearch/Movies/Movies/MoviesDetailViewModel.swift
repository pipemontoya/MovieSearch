//
//  MoviesDetailViewModel.swift
//  MovieSearch
//
//  Created by Andres Montoya on 8/8/19.
//  Copyright © 2019 Andres Montoya. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer
import AVKit

class MoviesDetailViewModel {
    
    var startingConstant: CGFloat  = 0.0
    let heightMax: CGFloat = 600
    let heightMin: CGFloat = 300
    var video: Video!
    
    func getVideo(with id: Int, handler: @escaping (Result<Bool, Error>) -> Void) {
        ApiService.shared.get(videos: id) { (result) in
            switch result {
            case .success(let videos):
                self.video = videos.first
                handler(.success(true))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
}
