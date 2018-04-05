//
//  MArtifactRow.swift
//  ViewMasterSwift
//
//  Created by Brandon Trapp on 4/4/18.
//  Copyright © 2018 Robert England. All rights reserved.
//

import Foundation

class MArtifactRow {
    var artifacts = [MArtifact]()
    let size: Int
    
    init (_ size: Int) {
        self.size = size
    }
    
    func setArtifact(_ position: Int, _ artifact: MArtifact) {
        if position >= 0 && position < size {
            artifacts[position] = artifact
        }
    }
    
    func getArtifact(_ position: Int) -> MArtifact? {
        if position >= 0 && position < size {
            return artifacts[position]
        } else {
            return nil
        }
    }
}
