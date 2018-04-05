//
//  MCabinet.swift
//  ViewMasterSwift
//
//  Created by Brandon Trapp on 4/3/18.
//  Copyright © 2018 Robert England. All rights reserved.
//

import Foundation

class MCabinet {
    var artifactRows = [MArtifactRow]()
    var location: String
    
    init(_ location: String) {
        self.location = location
    }
    
    func createRow(_ size: Int) {
        artifactRows.append(MArtifactRow(size))
    }
    
    func getRow(_ rowNumber: Int) -> MArtifactRow? {
        if rowNumber >= 0 && rowNumber < artifactRows.count {
            return artifactRows[rowNumber]
        }
        
        return nil
    }
}
