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

class PopularViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let viewModel = PopularViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getMovies {[weak self] (result) in
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

}

//MARK - DataSource

extension PopularViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MoviewTableViewCell else {
            return UITableViewCell()
        }
        let url = URL(string: (viewModel.movies[indexPath.row].imageUrl))
        cell.posterImageView.kf.setImage(with: url)
        cell.movieDescription.text = viewModel.movies[indexPath.row].overview
        cell.rateLabel.text = "\(viewModel.movies[indexPath.row].voteAverage)"
        cell.shadow(color: .white)
        return cell
    }
}

//MARK - Delegate

extension PopularViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175.0
    }
}

//MARK - XLPagerStrip

extension PopularViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Popular Movies")
    }
}
