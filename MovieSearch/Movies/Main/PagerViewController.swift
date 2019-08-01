//
//  PagerViewController.swift
//  MovieSearch
//
//  Created by Andres Montoya on 7/30/19.
//  Copyright © 2019 Andres Montoya. All rights reserved.
//

import Foundation
import XLPagerTabStrip

class pagerViewController: TwitterPagerTabStripViewController {
    
    weak var popular: MoviesViewController?
    weak var topRated: MoviesViewController?
    weak var upcoming: MoviesViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let popularS = UIStoryboard(name: "Movies", bundle: nil).instantiateInitialViewController()
        let topRatedS = UIStoryboard(name: "Movies", bundle: nil).instantiateInitialViewController()
        let upcomingS = UIStoryboard(name: "Movies", bundle: nil).instantiateInitialViewController()
        popular = popularS as? MoviesViewController
        popular?.viewModel = MoviesViewModel(index: 0)
        topRated = topRatedS as? MoviesViewController
        topRated?.viewModel = MoviesViewModel(index: 1)
        upcoming = upcomingS as? MoviesViewController
        upcoming?.viewModel = MoviesViewModel(index: 2)
        return [popular ?? UIViewController(), topRated ?? UIViewController(), upcoming ?? UIViewController()]
    }
    
}
