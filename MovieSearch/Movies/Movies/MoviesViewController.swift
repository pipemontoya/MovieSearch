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
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var headerConstraint: NSLayoutConstraint!
    
    
    var viewModel: MoviesViewModel?
    let transition = Animator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarHeightConstraint.constant = 0
        searchButton.addTarget(self, action: #selector(opensearchBar), for: .touchUpInside)
        pageControl.currentPage = viewModel?.index ?? 0
        categoryTitle.text = viewModel?.getTitle()
        navigationController?.navigationBar.isHidden = true
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? MovieDetailViewController,
            let movie = sender as? Movie {
            detailViewController.movie = movie
            detailViewController.transitioningDelegate = self
        }
    }
    @objc private func opensearchBar() {
        let heightValue = searchBarHeightConstraint.constant
        UIView.animate(withDuration: 0.5) {
            if heightValue == 45 {
                self.pageControl.isHidden = false
                self.searchBarHeightConstraint.constant = 0
                self.headerConstraint.constant = 120
                self.searchBar.resignFirstResponder()
            } else {
                self.searchBar.becomeFirstResponder()
                self.pageControl.isHidden = true
                self.headerConstraint.constant = 40
                self.searchBarHeightConstraint.constant = 45
            }
            self.view.layoutIfNeeded()
        }
    }
    
    
    
}

//MARK - tableViewDataSource

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.filteredSearch.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        let movie = viewModel?.filteredSearch[indexPath.row]
        let url = URL(string: (movie?.imageUrl ?? ""))
        UIView.transition(with: cell, duration: 0.5, options: .transitionCrossDissolve, animations: {
            cell.posterImageView.kf.setImage(with: url)
            cell.viewC.shadow(color: .white)
            cell.rateLabel.text = "\(movie?.voteAverage ?? 0.0)"
        })
        return cell
    }
}

//MARK - tableView Delegate

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 390.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detail", sender: viewModel?.filteredSearch[indexPath.row])
    }
}

//MARK: - XLPagerStrip

extension MoviesViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        let indicatorInfo = IndicatorInfo(title: viewModel?.getTitle() ?? "", image: UIImage(named: "star"))
        return indicatorInfo
    }
}


//MARK: Animation

extension MoviesViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let selectedIndexPathCell = tableView.indexPathForSelectedRow,
            let selectedCell = tableView.cellForRow(at: selectedIndexPathCell) as? MovieTableViewCell,
            let selectedCellSuperview = selectedCell.superview
            else {
                return nil
        }
        
        transition.originFrame = selectedCellSuperview.convert(selectedCell.frame, to: nil)
        transition.originFrame = CGRect(
            x: transition.originFrame.origin.x + 20,
            y: transition.originFrame.origin.y + 20,
            width: transition.originFrame.size.width - 40,
            height: transition.originFrame.size.height - 40
        )
        
        transition.presenting = true
        return transition
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}

extension MoviesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.isEmpty {
            viewModel?.filteredSearch = self.viewModel?.movies ?? [Movie]()
            tableView.reloadData()
            return
        }
        viewModel?.filteredSearch = (viewModel?.movies.filter({ (movie) -> Bool in
            if let searchText = searchBar.text?.lowercased() {
                return movie.title.lowercased().contains(searchText)
            } else {
                return false
            }
        })) ?? [Movie]()
        tableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        tableView.reloadData()
        self.searchBar.resignFirstResponder()
    }

}
