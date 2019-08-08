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
    var viewModel: MoviesViewModel?
    let transition = Animator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
}

//MARK - DataSource

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.movies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        let movie = viewModel?.movies[indexPath.row]
        let url = URL(string: (movie?.imageUrl ?? ""))
        cell.posterImageView.kf.setImage(with: url)
        cell.viewC.shadow(color: .white)
        cell.rateLabel.text = "\(movie?.voteAverage ?? 0.0)"
        return cell
    }
}

//MARK - Delegate

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400.0
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
        performSegue(withIdentifier: "detail", sender: viewModel?.movies[indexPath.row])
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
        //selectedCell.shadowView.isHidden = true
        return transition
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}
