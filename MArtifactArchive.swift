//
//  MArtifactArchive.swift
//  ViewMasterSwift
//
//  Created by Brandon Trapp on 4/4/18.
//  Copyright © 2018 Robert England. All rights reserved.
//

import Foundation

// Provides the master collection for all of the loaded artifacts
// Has arrays of the artifacts sorted by tag, by name, and by location

class MArtifactArchive {
    // The master list of all of the artifacts. Should be maintained to always be alphabetical
    static var artifacts = [MArtifact]()
    
    // The string to use as a filter when sorting for the catalog
    // Setting automatically calls functions to resort the appropriate dictionaries
    static var filterSection = "All" {
        didSet {
            MArtifactArchive.sortByTag()
            MArtifactArchive.sortAlphabetic()
        }
    }
    
    // The public-facing static dictionaries that hold the artifacts, filtered by the section, sorted in various ways
    // Dictionaries are of the format [String: (Int, [MArtifact])]
    // This means that for any given key (first letter, tag, etc.) you are given a tuple
    // This tuple's .0 element is the section number
    // The tuple's .1 element is the actual array of all of the artifacts that are in that section
    static var alphabeticArtifacts = [String: (Int, [MArtifact])]()
    static var chronologicalArtifacts = [String: (Int, [MArtifact])]()
    static var artifactsByTag = [String: (Int, [MArtifact])]()
    static var artifactsByLocation = [String: (Int, [MArtifact])]()
    
    // Adds an artifact to the master list
    // Will not show up in sorted dictionaries until the sort functions are called
    static func addArtifact(_ artifact: MArtifact) {
        artifacts.append(artifact)
    }
    
    // Sorting (sorted function) learned by using xcode documentatiton, and also looking at Dr. England's sample code
    static func sortAlphabetic() {
        // Reset the sorted dictionary... we will be refilling it from scratch
        alphabeticArtifacts = [String: (Int, [MArtifact])]()
        
        // The main array is already sorted alphabetically
        
        var lastFirstLetter = ""
        var letterIndex = 0
        
        // For each artifact (in order) in artifacts...
        for artifact in artifacts {
            // Check if the artifact is of the section we are filtering for
            if (MArtifactArchive.filterSection == "All" || artifact.section == MArtifactArchive.filterSection) {
                // Check the first letter of this artifact's name
                // If it's different from the last first letter, we're in a new section
                let firstLetter = String(describing: (artifact.name.first)!)
                if firstLetter != lastFirstLetter {
                    // Initialize the key for the new first letter
                    alphabeticArtifacts[firstLetter] = (0, [])
                    alphabeticArtifacts[firstLetter]?.0 = letterIndex
                    letterIndex = letterIndex + 1
                    lastFirstLetter = firstLetter
                }
                
                // Add the artifact to the section's array
                alphabeticArtifacts[firstLetter]?.1.append(artifact)
            }
        }
    }
    
    /* static func sortChronological() {
        chronologicalArtifacts = [String: (Int, [MArtifact])]()
        let sorted = artifacts.sorted() {$0.year < $1.year}
        
        var lastYear = "0"
        var yearIndex = 0
        
        for artifact in sorted {
            if (artifact.section == MArtifactArchive.filterSection || MArtifactArchive.filterSection == "All")
            {
                let year = artifact.year
                if year != lastYear {
                    chronologicalArtifacts[year] = (0, [])
                    chronologicalArtifacts[year]?.0 = yearIndex
                    yearIndex = yearIndex + 1
                    lastYear = year
                }
                chronologicalArtifacts[year]?.1.append(artifact)
            }
        }
    } */
    
    static func sortByTag() {
        // Reset the sorted dictionary... we will be refilling it from scratch
        artifactsByTag = [String: (Int, [MArtifact])]()
        
        var categoryIndex = 0
        
        // Create another array that is the names of all of the known tags sorted in order
        // so that the sections appear alphabetically in the tag view
        let tagsInOrder = MTag.tags.keys.sorted() { $0 < $1 }
        
        // For each tag...
        for tagName in tagsInOrder {
            // For each artifact...
            for artifact in artifacts {
                // If this artifact is in the right section...
                if (MArtifactArchive.filterSection == "All" || artifact.section == MArtifactArchive.filterSection) {
                    // And if this artifact has the right tag...
                    if artifact.tags.hasTag(tagName) {
                        // If artifactsByTag doesn't have tagName as a key yet, initialize that
                        if artifactsByTag[tagName] == nil {
                            artifactsByTag[tagName] = (categoryIndex, [])
                            categoryIndex = categoryIndex + 1
                        }
                        
                        // And finally, add the artifact to the dictionary under the key tagName
                        artifactsByTag[tagName]?.1.append(artifact)
                    }
                }
            }
        }
    }
    
    static func sortByLocation() {
        // Reset the sorted dictionary... we will be refilling it from scratch
        artifactsByLocation = [String: (Int, [MArtifact])]()
        
        var locationIndex = 0
        
        // For each artifact in artifacts...
        for artifact in artifacts {
            // Check if the artifact is of the section we are filtering for
            if (MArtifactArchive.filterSection == "All" || artifact.section == MArtifactArchive.filterSection) {
                // Check the location of this artifact
                // If the dictionary doesn't have an entry for it yet, initialize it
                let location = artifact.location
                if artifactsByTag[location] == nil {
                    // Initialize the key for the new location
                    artifactsByLocation[location] = (0, [])
                    artifactsByLocation[location]?.0 = locationIndex
                    locationIndex = locationIndex + 1
                }
                
                // Add the artifact to the section's array
                print("\(artifact.name): \(location)")
                artifactsByLocation[location]?.1.append(artifact)
            }
        }
    }
    
    static func loadArtifactsFromPlist() {
        // accessing plist taken from Dr. England's code in VMRPacket and VMRViewMasterPackets
        
        // If the artifacts have already been loaded, never load them again
        if artifacts.count != 0 {
            return
        }
        
        if let bundlePath = Bundle.main.path(forResource: "Artifacts", ofType: "plist") {
            let rawArtifactsArray = NSMutableArray(contentsOfFile: bundlePath)!
         
            for artifactData in rawArtifactsArray {
                // Set values from all of the different keys
                let artifactDataDictionary = artifactData as! NSDictionary
                let name = artifactDataDictionary.value(forKey: "name") as! String
                let description = artifactDataDictionary.value(forKey: "description") as! String
                let imagePath = artifactDataDictionary.value(forKey: "imagePath") as! String
                let section = artifactDataDictionary.value(forKey: "section") as! String
                let location = artifactDataDictionary.value(forKey: "location") as! String
                
                // Make a new artifact
                let artifact = MArtifact(name: name, description: description, imagePath: imagePath, section: section, location: location)
                
                // Set the tags of the new artifact
                let tags = artifactDataDictionary.value(forKey: "tags") as! NSArray
                for tag in tags {
                    artifact.tags.setTag(tag as! String)
                }
                
                // Add the artifact to the main array
                addArtifact(artifact)
            }
        }
        
        artifacts = artifacts.sorted() {$0.name < $1.name}
        
        sortAlphabetic()
        sortByTag()
        sortByLocation()
    }
}
