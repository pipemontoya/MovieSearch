//
//  OnlineSearchViewController.swift
//  MovieSearch
//
//  Created by Andres Montoya on 8/11/19.
//  Copyright © 2019 Andres Montoya. All rights reserved.
//

import UIKit

class OnlineSearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var closeButton: UIButton!
    
    var viewModel = OnlineSearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    @objc func close() {
        dismiss(animated: true)
    }
}

extension OnlineSearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onlineCell", for: indexPath) as? OnlineCollectionViewCell else {return UICollectionViewCell()}
        guard viewModel.movies.count != 0 else {return cell}
        let url = URL(string: (viewModel.movies[indexPath.row].imageUrl))
        cell.movieImageView.kf.setImage(with: url)
        return cell
    }
    
    
}

extension OnlineSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.getMovies(by: searchText) { (movies) in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
