//
//  VMRPacketsSortedByNumberDataSource.swift
//  Moosnick Museum
//
//  Created by Robert England on 3/11/18 for ViewMasterSwift
//  Copyright (c) 2018 Robert England. All rights reserved.
//
//  Description: Provides the table view data for the packets sorted by number
//

import UIKit

// Note: Thie *automatically* picks up UITableDataSource protocol through
//    VMRPacketsTableDataSourceProtocol

class MNumberDataSource: NSObject, MTableViewDataSourceProtocol {
    
    //// Protocol methods to comply with "VMRPacketsDataSource" protocol
    
    // Getters for properties for navagation and tab bars
    var name: String {
        get {
            return "Year"
        }
    }
    var navigationBarName: String {
        get {
            return "Artifacts by Year"
        }
    }
    var tabBarImage: UIImage {
        get {
            return UIImage(named: "TabNumber.png")!
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

        var thisYear = "0000"
        // get the section with the correct index
        for (year, value) in MArtifactArchive.chronologicalArtifacts {
            if value.0 == indexPath.section {
                thisYear = year
            }
        }
        return (MArtifactArchive.chronologicalArtifacts[thisYear]?.1[indexPath.row])!
    }
    
    // (Don't really use this)
    func titleForHeaderInSection(tableView: UITableView, section: Int) -> String {
        return ""
    }
    
//    #pragma mark - UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MTableViewCell", for: indexPath) as! MTableViewCell
        
        // Set the packet for this cell as indicated by the datasource
        cell.artifact = artifactForindexPath(indexPath: indexPath as NSIndexPath)
        cell.setNeedsDisplay()
        return cell
    }
    
    // (changed func name via TheElements, swift edition)
    func numberOfSections(in tableView: UITableView) -> Int {
        // The number of different sections in the table depends on how many different years there were in the data
        return MArtifactArchive.chronologicalArtifacts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /// get the section with the correct index
        for (_, value) in MArtifactArchive.chronologicalArtifacts {
            if value.0 == section {
                return value.1.count
            }
        }
        return 0
     }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        for (year, value) in MArtifactArchive.chronologicalArtifacts {
            if value.0 == section {
                return year
            }
        }
        
        return nil
    }
}
