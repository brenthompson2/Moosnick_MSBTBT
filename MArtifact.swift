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
    var imagePath: String
    var section: String
    var location: String
    var tags: MTag
    
    init() {
        name = "DEFAULT_NAME"
        description = "DEFAULT_DESCRIPTION"
        imagePath = "A071Front_256.png"
        section = "General"
        location = "Storage"
        tags = MTag()
    }
    
    init(name: String, description: String, imagePath: String, section: String, location: String) {
        self.name = name
        self.description = description
        self.imagePath = imagePath
        self.section = section
        self.location = location
        self.tags = MTag()
    }
}
