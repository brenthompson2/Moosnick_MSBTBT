//
//  VMRPacketsCollectionDataSource.swift
//  Moosnick Museum
//
//  Created by Robert England on 3/11/18 for ViewMasterSwift
//  Copyright (c) 2018 Robert England. All rights reserved.
//
//  Description: Provides the table view data for the packets sorted by number
//

import UIKit

// Note: Thie *automatically* picks up UICollectionDataSource protocol through
//    VMRPacketsCollectionDataSourceProtocol

class MCollectionDataSource: NSObject, MCollectionDataSourceProtocol {
    
    
    //// Protocol methods to comply with "VMRPacketsDataSource" protocol
    
    // Getters for properties for navagation and tab bars
    var name: String {
        get {
            return "Grid"
        }
    }
    var navigationBarName: String {
        get {
            return "Artifacts in Grid"
        }
    }
    var tabBarImage: UIImage {
        get {
            return UIImage(named: "TabGrid.png")!
        }
    }
    
    //// Make UICollectionViewDataSource happy...
    
    // Number of items in the section is the number of packets
    func collectionView(_ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return MArtifactArchive.artifacts.count
    }
    
    // Just one section in the grid
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Return a cell for the corresponding index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MCollectionViewCell", for: indexPath as IndexPath) as! MCollectionViewCell

        // Set the packet for this cell as indicated by the datasource
        cell.artifact = artifactForIndexPath(indexPath: indexPath as NSIndexPath)
        cell.setNeedsDisplay()
        return cell
    }
    
    // Return the packet for the given index path (--> Take a closer look at this!)
    func artifactForIndexPath(indexPath: NSIndexPath) -> MArtifact {
        return MArtifactArchive.artifacts[indexPath.row]
    }
}
