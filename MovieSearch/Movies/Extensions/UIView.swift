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
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowColor = color.cgColor
    }
}
