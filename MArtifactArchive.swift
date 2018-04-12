//
//  MArtifactArchive.swift
//  ViewMasterSwift
//
//  Created by Brandon Trapp on 4/4/18.
//  Copyright © 2018 Robert England. All rights reserved.
//

import Foundation

class MArtifactArchive {
    static var artifacts = [MArtifact]()
    
    static var alphabeticArtifacts = [String: (Int, [MArtifact])]()
    static var chronologicalArtifacts = [String: (Int, [MArtifact])]()
    static var artifactsByCategory = [String: (Int, [MArtifact])]()
    
    static func addArtifact(_ artifact: MArtifact) {
        artifacts.append(artifact)
    }
    
    // Sorting (sorted function) learned by using xcode documentatiton, and also looking at Dr. England's sample code
    static func sortAlphabetic() {
        alphabeticArtifacts = [String: (Int, [MArtifact])]()
        let sorted = artifacts.sorted() {$0.name < $1.name}
        
        var lastFirstLetter = ""
        var letterIndex = 0
        
        for artifact in sorted {
            let firstLetter = String(describing: (artifact.name.first)!)
            if firstLetter != lastFirstLetter {
                alphabeticArtifacts[firstLetter] = (0, [])
                alphabeticArtifacts[firstLetter]?.0 = letterIndex
                letterIndex = letterIndex + 1
                lastFirstLetter = firstLetter
            }
            alphabeticArtifacts[firstLetter]?.1.append(artifact)
        }
    }
    
    static func sortChronological() {
        chronologicalArtifacts = [String: (Int, [MArtifact])]()
        let sorted = artifacts.sorted() {$0.year < $1.year}
        
        var lastYear = "0"
        var yearIndex = 0
        
        for artifact in sorted {
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
    
    static func sortByCategory() {
        artifactsByCategory = [String: (Int, [MArtifact])]()
        let sorted = artifacts.sorted() {$0.name < $1.name}
        
        var categoryIndex = 0
        
        let categoriesInOrder = MCategory.categories.keys.sorted() { $0 < $1 }
        
        for catName in categoriesInOrder {
            artifactsByCategory[catName] = (categoryIndex, [])
            categoryIndex = categoryIndex + 1
            for artifact in sorted {
                if artifact.category.hasCategory(catName) {
                    artifactsByCategory[catName]?.1.append(artifact)
                }
            }
        }
    }
    
    static func loadArtifactsFromPlist() {
        // accessing plist taken from Dr. England's code in VMRPacket and VMRViewMasterPackets
        if artifacts.count != 0 {
            return
        }
        
        if let bundlePath = Bundle.main.path(forResource: "Artifacts", ofType: "plist") {
            let rawArtifactsArray = NSMutableArray(contentsOfFile: bundlePath)!
         
            for artifactData in rawArtifactsArray {
                let artifactDataDictionary = artifactData as! NSDictionary
                let name = artifactDataDictionary.value(forKey: "name") as! String
                let description = artifactDataDictionary.value(forKey: "description") as! String
                let year = artifactDataDictionary.value(forKey: "year") as! String
                let imagePath = artifactDataDictionary.value(forKey: "imagePath") as! String
                
                print("Name: \(name)\nDescription: \(description)\nDate: \(year)\n")
                
                let artifact = MArtifact(name: name, description: description, year: year, imagePath: imagePath)
                
                let categories = artifactDataDictionary.value(forKey: "categories") as! NSArray
                for category in categories {
                    artifact.category.setCategory(category as! String)
                }
                
                addArtifact(artifact)
            }
        }
        
        sortAlphabetic()
        sortByCategory()
        sortChronological()
    }
}
