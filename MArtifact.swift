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
    var year: String
    var imagePath: String
    var section: String
    var category: MCategory
    
    init() {
        name = "DEFAULT_NAME"
        description = "DEFAULT_DESCRIPTION"
        year = "2018"
        imagePath = "A071Front_256.png"
        section = "General"
        category = MCategory()
    }
    
    init(name: String, description: String, year: String, imagePath: String, section: String) {
        self.name = name
        self.description = description
        self.year = year
        self.imagePath = imagePath
        self.section = section
        self.category = MCategory()
    }
}
