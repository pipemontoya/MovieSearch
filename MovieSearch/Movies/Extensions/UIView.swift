//
//  UIView.swift
//  MovieSearch
//
//  Created by Andres Montoya on 7/31/19.
//  Copyright © 2019 Andres Montoya. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func shadow(color: UIColor) {
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: -10, height: 10)
        self.layer.shadowColor = color.cgColor
    }
    
    func blur() {
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        visualEffectView.frame = self.bounds
        self.addSubview(visualEffectView)
    }
}
