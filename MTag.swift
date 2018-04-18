//
//  MCategory.swift
//  ViewMasterSwift
//
//  Created by Brandon Trapp on 4/3/18.
//  Copyright © 2018 Robert England. All rights reserved.
//

import Foundation

// A class to keep track of tags for an artifact
// Uses bitwise binary operations to store and check whether
// Or not an object has a specific tag

class MTag {
    // Master list of all known tag names
    static var tags = [String: Int]()
    
    // The number that represents what tags an object has
    // Used as a binary number, so 1011 means that the object has the fourth, second, and first tags
    var tagCode = 0
    
    // Returns true if this object has no tags set
    var isUntagged: Bool { return tagCode == 0 }
    
    // Sets a specific tag bit for this object based on a given string
    // If the given tag string is not already known, it will add it to the master list
    @discardableResult func setTag(_ name: String) -> Bool {
        // Return false (tag set unsuccessful) if this object already has the tag set
        if hasTag(name) {
            return false
        }
        
        // Get the value (a power of 2, so a single binary bit) that represents this tag
        var code = MTag.tags[name]
        
        // If the value doesn't exist, make the tag and try again
        if code == nil {
            MTag.addTagName(name)
            code = MTag.tags[name]
        }
        
        // Add the binary bit to this object's tag code
        tagCode = tagCode + code!
        
        return true
    }
    
    // Removes a specific tag bit for this object based on a given string
    @discardableResult func removeTag(_ name: String) -> Bool {
        // If this object does not already have the given tag, then return false
        if !hasTag(name) {
            return false
        }
        
        // Get the value (a power of 2, so a single binary bit) that represents this tag
        let code = MTag.tags[name]
        
        // If the value doesn't exist, return false for trying to remove a tag that doesn't exist
        if code == nil {
            return false
        }
        
        // Subtract the binary bit from the tag code
        tagCode = tagCode - code!
        
        return true
    }
    
    // Checks to see if this object has a specific tag bit set
    func hasTag(_ name: String) -> Bool {
        // Get the value (a power of 2, so a single binary bit) that represents this tag
        let code = MTag.tags[name]
        
        // If the value doesn't exist, return false for trying to check a tag that doesn't exist
        if code == nil {
            return false
        }
        
        // Return whether or not the object's tag code bitwise anded with the tag's code are the same
        // ex: object:      0110
        //     code:        0010
        //     object&code: 0010
        // The two are equal, so the object has the tag
        return (tagCode & code!) == code!
    }
    
    // Adds a new tag name to the master list
    @discardableResult static func addTagName(_ name: String) -> Bool {
        // If the tag already exists, return false
        if tags[name] != nil {
            return false
        }
    
        // Get the next power of two, and set that as the value to the tag's key
        // to get around 'pow' not working:
        // https://stackoverflow.com/questions/42338009/how-to-use-pow-in-swift-3-and-get-an-int
        tags[name] = Int(powf(2, Float(tags.count)))
        
        return true
    }
}
