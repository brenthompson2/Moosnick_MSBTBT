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
    
    // Sorting (sorted function) learned by using xcode documentatiton, and also looking at Dr. England's sample code
    static var alphabeticArtifacts: [String: [MArtifact]] {
        var toReturn = [String: [MArtifact]]()
        let sorted = artifacts.sorted() {$0.name < $1.name}
        
            for artifact in sorted {
                let firstLetter = String(describing: artifact.name.first)
                toReturn[firstLetter]?.append(artifact)
            }
        
        return toReturn
    }
    
    static var chronologicalArtifacts: [String: [MArtifact]] {
        var toReturn = [String: [MArtifact]]()
        let sorted = artifacts.sorted() {$0.date < $1.date}
        
        for artifact in sorted {
            // From http://bluelemonbits.com/index.php/2017/02/20/get-date-day-month-or-year-in-swift-3-0/
            let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
            let year = (calendar?.component(NSCalendar.Unit.year, from: artifact.date))!
            
            let yearString = String(describing: year)
            toReturn[yearString]?.append(artifact)
        }
        
        return toReturn
    }
    
    static var artifactsByCategory: [String: [MArtifact]] {
        var toReturn = [String: [MArtifact]]()
        let sorted = artifacts.sorted() {$0.name < $1.name}
        
        for (catName, _) in MCategory.categories {
            for artifact in sorted {
                if artifact.category.hasCategory(catName) {
                    toReturn[catName]?.append(artifact)
                }
            }
        }
        
        return toReturn
    }
    
    static func addArtifact(_ artifact: MArtifact) {
        artifacts.append(artifact)
    }
    
    static func loadArtifactsFromPlist() {
        // accessing plist taken from Dr. England's code in VMRPacket and VMRViewMasterPackets
        
        if let bundlePath = Bundle.main.path(forResource: "Artifacts", ofType: "plist") {
            let rawArtifactsArray = NSMutableArray(contentsOfFile: bundlePath)!
         
            for artifactData in rawArtifactsArray {
                let artifactDataDictionary = artifactData as! NSDictionary
                let name = artifactDataDictionary.value(forKey: "name") as! String
                let description = artifactDataDictionary.value(forKey: "description") as! String
                let date = artifactDataDictionary.value(forKey: "date") as! Date
                let imagePath = artifactDataDictionary.value(forKey: "imagePath") as! String
                
                print("Name: \(name)\nDescription: \(description)\nDate: \(date)\n")
                
                let artifact = MArtifact(name: name, description: description, date: date, imagePath: imagePath)
                
                let categories = artifactDataDictionary.value(forKey: "categories") as! NSArray
                for category in categories {
                    _ = artifact.category.setCategory(category as! String)
                }
                
                addArtifact(artifact)
            }
        }
    }
}
