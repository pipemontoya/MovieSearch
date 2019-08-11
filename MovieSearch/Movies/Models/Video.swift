//
//  Video.swift
//  MovieSearch
//
//  Created by Andres Montoya on 8/8/19.
//  Copyright © 2019 Andres Montoya. All rights reserved.
//

import Foundation
import SwiftyJSON

class Video: NSObject {
    var name = ""
    var id = ""
    var site = ""
    var key = ""
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.id = json["id"].stringValue
        self.site = json["site"].stringValue
        self.key = json["key"].stringValue
    }
}
