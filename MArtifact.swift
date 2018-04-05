//
//  MArtifact.swift
//  ViewMasterSwift
//
//  Created by Brandon Trapp on 4/3/18.
//  Copyright © 2018 Robert England. All rights reserved.
//

import Foundation

class MArtifact {
    var name: String
    var description: String
    var date: Date
    var imagePath: String
    var category: MCategory
    
    init() {
        name = "DEFAULT_NAME"
        description = "DEFAULT_DESCRIPTION"
        date = Date.distantPast
        imagePath = ""
        category = MCategory()
    }
    
    init(name: String, description: String, date: Date, imagePath: String) {
        self.name = name
        self.description = name
        self.date = date
        self.imagePath = imagePath
        self.category = MCategory()
    }
}
