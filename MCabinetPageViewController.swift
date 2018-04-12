//
//  MCabinetViewController.swift
//  ViewMasterSwift
//
//  View Controller to manage the PageViewController displaying all of the cabinets
//
//  Created by Brendan Thompson on 4/10/18.
//  Copyright © 2018 Robert England. All rights reserved.
//

import UIKit

class MCabinetViewController: UIPageViewController {

    required init (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        dataSource = self
        
    }
    
    
    
}
