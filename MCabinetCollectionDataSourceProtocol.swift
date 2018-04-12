//
//  MCabinetCollectionDataSourceProtocol
//  Moosnick Museum
//
//  Created by Robert England on 3/11/18 for ViewMasterSwift
//  Copyright (c) 2018 Robert England. All rights reserved.
//

import UIKit

protocol MCabinetCollectionDataSourceProtocol : UICollectionViewDataSource {
    
    // These properties are used by the view controller for the navagation bar and tab
    var name :String { get }
    var navigationBarName: String { get }
    var tabBarImage: UIImage { get }
    
    // This property determines the style of table view to be displayed
//    var tableViewStyle: UITableViewStyle { get }
    
    // This method provides a standardized way of asking for the packet at a
    //    specific index path, regardless of the sorting or display technique
    //    for the particular datasource
    func artifactForIndexPath(indexPath: NSIndexPath) -> MArtifact
      
}
