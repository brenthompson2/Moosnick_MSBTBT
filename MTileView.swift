//
//  MTileView
//  Moosnick Museum
//
//  Created by Robert England on 3/11/18 for ViewMasterSwift
//  Copyright (c) 2018 Robert England. All rights reserved.
//
//  Description: VIEW: Draws the small tile view of a packet displayed in a tableview row.
//

import UIKit

class MTileView: UIView {
    var artifact : MArtifact
    
    override init(frame aRect: CGRect) {
        artifact = MArtifact()
        super.init(frame: aRect)
    }

    required init (coder aDecoder: NSCoder) {
        artifact = MArtifact()
        super.init(coder: aDecoder)!
    }

    // Google: "swift cgrectmake"
//https://stackoverflow.com/questions/38335046/update-cgrectmake-to-cgrect-in-swift-3-automatically
// AND.. shows how to update to current Swift syntax!
    override func draw(_ rect: CGRect) {
        let tileImage = UIImage(named: artifact.imagePath)
//        let tileImageRectangle = CGRectMake(0, 0, tileImage!.size.width, tileImage!.size.height)
        let tileImageRectangle = CGRect(x:0, y:0, width:tileImage!.size.width / 2, height:tileImage!.size.height / 2)

        tileImage?.draw(in: tileImageRectangle)
    }
}
