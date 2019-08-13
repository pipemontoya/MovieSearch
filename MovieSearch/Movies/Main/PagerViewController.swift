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
    var viewModel = PagerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let viewControllers = viewModel.subscribeVC(views: [.Movies, .Movies, .Movies])
        for (index, viewController) in viewControllers.enumerated() {
            viewController.viewModel = MoviesViewModel(index: index)
        }
        return viewControllers
    }
    
}
