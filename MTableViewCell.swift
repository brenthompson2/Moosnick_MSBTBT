//
//  MTableViewCell
//  Moosnick Museum
//
//  Created by Robert England on 3/11/18 for ViewMasterSwift
//  Copyright (c) 2018 Robert England. All rights reserved.
//

import UIKit

class MTableViewCell: UITableViewCell {
    var artifact : MArtifact {
        didSet {
            // Associate a packet with the tile view in this cell
            let artifactTileView = self.contentView.viewWithTag(1) as? MTileView
            artifactTileView!.artifact = self.artifact
            
            // Set the label to the name of the artifact
            var labelView = self.contentView.viewWithTag(2) as? UILabel
            labelView!.text = self.artifact.name
            
            // Set the label to the description of the artifact (excerpt)
            labelView = self.contentView.viewWithTag(4) as? UILabel
            labelView!.text = self.artifact.description
            
            // Tell the system these need refreshing
            artifactTileView!.setNeedsDisplay()
            labelView!.setNeedsDisplay()
        }
    }
    
    required init (coder aDecoder: NSCoder) {
        artifact = MArtifact()
        super.init(coder: aDecoder)!
    }
    
    
}
