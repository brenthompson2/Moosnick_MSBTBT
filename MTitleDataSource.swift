//
//  VMRPacketsSortedByTitleDataSource.swift
//  Moosnick Museum
//
//  Created by Robert England on 3/11/18 for ViewMasterSwift
//  Copyright (c) 2018 Robert England. All rights reserved.
//
//  Description: Provides the table view data for the packets sorted by name
//

import UIKit

// Note: Thie *automatically* picks up UITableDataSource protocol through
//    VMRPacketsTableDataSourceProtocol

class MTitleDataSource: NSObject, MTableViewDataSourceProtocol {
    
 
    //// Protocol methods to comply with "VMRPacketsDataSource" protocol
    
    // Getters for properties for navagation and tab bars
    var name: String {
        get {
            return "Name"
        }
    }
    var navigationBarName: String {
        get {
            return "Artifacts"
        }
    }
    var tabBarImage: UIImage {
        get {
            return UIImage(named: "TabTitle.png")!
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
//        println("packetForIndexPath")

        var firstLetter = "a"
        // get the section with the correct index
        for (letter, value) in MArtifactArchive.alphabeticArtifacts {
            if value.0 == indexPath.section {
                firstLetter = letter
            }
        }
        return (MArtifactArchive.alphabeticArtifacts[firstLetter]?.1[indexPath.row])!
    }
    
    // (Don't really use this)
    func titleForHeaderInSection(tableView: UITableView, section: Int) -> String {
        return ""
    }
    
//    #pragma mark - UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 //       println("Making a cell...")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MTableViewCell", for: indexPath) as! MTableViewCell
        
        // Set the packet for this cell as indicated by the datasource
        cell.artifact = artifactForindexPath(indexPath: indexPath as NSIndexPath)
        cell.setNeedsDisplay()
        return cell
    }
    
    // (changed func name via TheElements, swift edition)
    func numberOfSections(in tableView: UITableView) -> Int {
        // The number of different sections in thei table depends on the number of different first letters
        return MArtifactArchive.alphabeticArtifacts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // get the section with the correct index
        for (_, value) in MArtifactArchive.alphabeticArtifacts {
            if value.0 == section {
                return value.1.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        for (letter, value) in MArtifactArchive.alphabeticArtifacts {
            if value.0 == section {
                return letter
            }
        }
        return nil
    }
  
    
}
