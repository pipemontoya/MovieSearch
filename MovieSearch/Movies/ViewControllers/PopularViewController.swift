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
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    let viewModel = PopularViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getMovies {[weak self] (result) in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.moviesCollectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}

//MARK - DataSource

extension PopularViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviesCell", for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        let url = URL(string: (viewModel.movies[indexPath.row].imageUrl))
        cell.posterImageView.kf.setImage(with: url)
        cell.movieDescription.text = viewModel.movies[indexPath.row].overview
        cell.shadow(color: .white)
        return cell
    }
    
    
}

//MARK - Delegate

extension PopularViewController: UICollectionViewDelegate {
    
}

//MARK - XLPagerStrip

extension PopularViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Popular Movies")
    }
}
