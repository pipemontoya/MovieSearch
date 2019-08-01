//
//  ViewController.swift
//  MovieSearch
//
//  Created by Andres Montoya on 7/30/19.
//  Copyright © 2019 Andres Montoya. All rights reserved.
//

import UIKit
import Kingfisher
import XLPagerTabStrip

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: MoviesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getMovies {[weak self] (result) in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    prepare
}

//MARK - DataSource

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.movies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MoviewTableViewCell else {
            return UITableViewCell()
        }
        let url = URL(string: (viewModel?.movies[indexPath.row].imageUrl ?? ""))
        cell.hasVideoImage.image = viewModel?.movies[indexPath.row].video ?? false ? UIImage(named: "play") : UIImage(named: "play")
        cell.title.text = viewModel?.movies[indexPath.row].title
        cell.posterImageView.kf.setImage(with: url)
        cell.viewC.shadow(color: .white)
        cell.movieDescription.text = viewModel?.movies[indexPath.row].overview
        cell.rateLabel.text = "\(viewModel?.movies[indexPath.row].voteAverage ?? 0.0)"
        return cell
    }
}

//MARK - Delegate

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotation = CATransform3DTranslate(CATransform3DIdentity, -200, 10, 0)
        cell.layer.transform = rotation
        cell.alpha = 0.3
        UIView.animate(withDuration: 0.5) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//MARK - XLPagerStrip

extension MoviesViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        let indicatorInfo = IndicatorInfo(title: viewModel?.getTitle() ?? "", image: UIImage(named: "star"))
        return indicatorInfo
    }
}
