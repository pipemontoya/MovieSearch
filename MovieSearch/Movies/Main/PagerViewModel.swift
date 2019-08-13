//
//  PagerViewModel.swift
//  MovieSearch
//
//  Created by Andres Montoya on 8/12/19.
//  Copyright © 2019 Andres Montoya. All rights reserved.
//

import Foundation
import UIKit

enum Views: CaseIterable {
    case Movies
    var named: String {
        switch self {
        case .Movies: return "Movies"
        }
    }
}

class PagerViewModel {
    
    private var suscribedVC = [Views]()
    
    func viewController(_ content: Views, navigation: Bool = false) -> MoviesViewController {
        let viewController = UIStoryboard(name: content.named, bundle: Bundle.main)
            .instantiateInitialViewController() ?? MoviesViewController()
        return viewController as! MoviesViewController
    }
    
    func viewControllers(_ contents: [Views],navigation: Bool = false) -> [MoviesViewController] {
        var viewControllers: [UIViewController] = []
        for content in contents {
            viewControllers.append(viewController(content, navigation: navigation))
        }
        return viewControllers as! [MoviesViewController]
    }
    ///Suscribe the views that will be shown
    public func subscribeVC(views: [Views]) -> [MoviesViewController] {
        suscribedVC = views
        return viewControllers(views, navigation: true)
    }
}
