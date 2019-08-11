//
//  MovieDetailViewController.swift
//  MovieSearch
//
//  Created by Andres Montoya on 8/1/19.
//  Copyright © 2019 Andres Montoya. All rights reserved.
//

import Foundation
import UIKit
import YoutubePlayer_in_WKWebView


class MovieDetailViewController: UIViewController {
    
    // constraints
    @IBOutlet weak var heightContentView: NSLayoutConstraint!
    
    //vars - lets
    var movie: Movie?
    var viewModel = MoviesDetailViewModel()

    //Outlets
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        backView.blur()
        playButton.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        viewModel.getVideo(with: movie?.id ?? 0) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.playButton.isEnabled = true
                    self.playButton.setImage(UIImage(named: "play"), for: .normal)
                    break
                case .failure(let error):
                    self.playButton.isEnabled = false
                    self.playButton.setImage(UIImage(named: "cantPlay"), for: .normal)
                    print(error)
                }
            }
        }
        let url = URL(string: (movie?.imageUrl ?? ""))
        moviePoster.kf.setImage(with: url)
        moviePoster.layer.cornerRadius = 10
    }
}
//Actions

extension MovieDetailViewController {
    @objc func playVideo() {
        guard let viewController = UIStoryboard(name: "Video", bundle: nil)
            .instantiateInitialViewController() as? VideoViewController else {return}
        viewController.key = viewModel.video.key
        present(viewController, animated: true, completion: nil)
    }
}

//Animation methods

extension MovieDetailViewController {
    @IBAction func dragGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: contentView)
        switch sender.state {
        case .began:
            viewModel.startingConstant = self.heightContentView.constant
        case .changed:
            if heightContentView.constant > viewModel.heightMax {
                heightContentView.constant = viewModel.heightMax
            } else if heightContentView.constant <= viewModel.heightMax {
                heightContentView.constant = viewModel.startingConstant - translation.y
            }
            if heightContentView.constant <= 200 {
                dismiss(animated: true)
            }
        case .ended:
            if translation.y < 0 {
                animate(with: viewModel.heightMax)
            } else {
                animate(with: viewModel.heightMin)
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

//MARK: TableView Datasource

extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "title") as? MoviewDetailTableViewCell else {return UITableViewCell()}
        cell.titleMovie.text = movie?.title
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let releaseDate = formatter.date(from: movie?.releaseDate ?? "")
        formatter.dateFormat = "MMMM d, yyyy"
        cell.releaseDateMoview.text = formatter.string(from: releaseDate ?? Date())
        cell.synopsisLabel.text = movie?.overview
        return cell
    }
}

extension MovieDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500.0
    }
}
