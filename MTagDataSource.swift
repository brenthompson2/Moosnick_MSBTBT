//
//  MTagDataSource.swift
//  Moosnick Museum
//
//  Created by Robert England on 3/11/18 for ViewMasterSwift
//  Copyright (c) 2018 Robert England. All rights reserved.
//
//  Description: Provides the table view data for the artifacts sorted by tag
//

import UIKit

// Note: Thie *automatically* picks up UITableDataSource protocol through
//    VMRPacketsTableDataSourceProtocol

class MTagDataSource: NSObject, MTableViewDataSourceProtocol {
    
    //// Protocol methods to comply with "MTableViewDataSourceProtocol" protocol
    
    // Getters for properties for navagation and tab bars
    var name: String {
        get {
            return "Tag"
        }
    }
    var navigationBarName: String {
        get {
            return "Artifacts by Tag"
        }
    }
    var tabBarImage: UIImage {
        get {
            return UIImage(named: "TabCategory.png")!
        }
    }
    
    // Sorted by titles is a plain table style
    var tableViewStyle: UITableViewStyle {
        get {
            return UITableViewStyle.plain
        }
    }
    
    // Return the packet for the given index path (--> Take a closer look at this!)
    func artifactForindexPath(indexPath: NSIndexPath) -> MArtifact {
        var thisCategory = ""
        // get the section with the correct index
        for (tag, value) in MArtifactArchive.artifactsByTag {
            if value.0 == indexPath.section {
                thisCategory = tag
            }
        }
        return (MArtifactArchive.artifactsByTag[thisCategory]?.1[indexPath.row])!
    }
    
//    #pragma mark - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MTableViewCell", for: indexPath) as! MTableViewCell
        
        // Set the packet for this cell as indicated by the datasource
        cell.artifact = artifactForindexPath(indexPath: indexPath as NSIndexPath)
        cell.setNeedsDisplay()
        return cell
    }
    
    // (Don't really use this)
    func titleForHeaderInSection(tableView: UITableView, section: Int) -> String {
        return ""
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // The number of different sections in thetable depends on how many tags have been used
        return MArtifactArchive.artifactsByTag.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /// get the section with the correct index
        for (_, value) in MArtifactArchive.artifactsByTag {
            if value.0 == section {
                return value.1.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // get the section that has the same section index as what we are trying to get the name of
        for (tag, value) in MArtifactArchive.artifactsByTag {
            if value.0 == section {
                return tag
            }
        }
        
        return nil
    }
  
    
}
