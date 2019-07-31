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
    
    weak var voteAverangeVC: PopularViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.black
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let storyBoardVoteAverange = UIStoryboard(name: "Popular", bundle: nil)
        let voteAverangeVCFS = storyBoardVoteAverange.instantiateInitialViewController()
        voteAverangeVC = voteAverangeVCFS as? PopularViewController
        
        return [voteAverangeVC!]
    }
    
}
