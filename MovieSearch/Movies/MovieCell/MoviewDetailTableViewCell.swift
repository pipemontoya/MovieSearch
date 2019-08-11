//
//  MoviewDetailTableViewCell.swift
//  MovieSearch
//
//  Created by Andres Montoya on 8/11/19.
//  Copyright © 2019 Andres Montoya. All rights reserved.
//

import UIKit

class MoviewDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var releaseDateMoview: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
