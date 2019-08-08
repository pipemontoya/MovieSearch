//
//  MovieDetailViewController.swift
//  MovieSearch
//
//  Created by Andres Montoya on 8/1/19.
//  Copyright © 2019 Andres Montoya. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer
import AVKit

class MovieDetailViewController: UIViewController {
    
    // constraints
    @IBOutlet weak var heightContentView: NSLayoutConstraint!
    
    //var
    var movie: Movie?
    var startingConstant: CGFloat  = 0.0
    
    //Outlets
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        contentView.shadow(color: .darkGray)
        backView.blur()
        let url = URL(string: (movie?.imageUrl ?? ""))
        moviePoster.kf.setImage(with: url)
    }
}

//Animation methods

extension MovieDetailViewController {
    @IBAction func dragGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: contentView)
        switch sender.state {
        case .began:
            self.startingConstant = self.heightContentView.constant
        case .changed:
            if heightContentView.constant > 529 {
                heightContentView.constant = 529
            } else if heightContentView.constant <= 529 {
                heightContentView.constant = startingConstant - translation.y
            }
            if heightContentView.constant <= 200 {
                dismiss(animated: true)
            }
        case .ended:
            if translation.y < 0 {
                animate(with: 529)
            } else {
                animate(with: 300)
            }
        default:
            break
        }
    }
    
    private func animate(with constant: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            self.heightContentView.constant = constant
            self.view.layoutIfNeeded()
        }
    }
}

// Video function

extension MovieDetailViewController {
    
    func video(with url: String) {
        guard let videoURL = URL(string: url) else { return }
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
}
