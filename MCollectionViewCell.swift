//
//  MCollectionViewCell
//  Moosnick Museum
//
//  Created by Robert England on 3/11/18 for ViewMasterSwift
//  Copyright (c) 2018 Robert England. All rights reserved.
//

import UIKit

class MCollectionViewCell: UICollectionViewCell {
    
    var artifact : MArtifact {
        didSet {
            // Associate a packet with the image view in this cell
            let imageView = self.contentView.viewWithTag(1) as! UIImageView
            imageView.image = UIImage(named: artifact.imagePath)
            // Tell the system these need refreshing
            imageView.setNeedsDisplay()
        }
    }
    
    required init (coder aDecoder: NSCoder) {
        artifact = MArtifact()
        super.init(coder: aDecoder)!
    }
    
    
}
