//
//  MCategory.swift
//  ViewMasterSwift
//
//  Created by Brandon Trapp on 4/3/18.
//  Copyright © 2018 Robert England. All rights reserved.
//

import Foundation

class MTag {
    static var tags = [String: Int]()
    
    var tagCode = 0
    
    var isUntagged: Bool { return tagCode == 0 }
    
    @discardableResult func setTag(_ name: String) -> Bool {
        if hasTag(name) {
            return false
        }
        
        var code = MTag.tags[name]
        
        if code == nil {
            MTag.addTagName(name)
            code = MTag.tags[name]
        }
        
        tagCode = tagCode + code!
        
        return true
    }
    
    @discardableResult func removeTag(_ name: String) -> Bool {
        if !hasTag(name) {
            return false
        }
        
        let code = MTag.tags[name]
        
        if code == nil {
            return false
        }
        
        tagCode = tagCode - code!
        
        return true
    }
    
    func hasTag(_ name: String) -> Bool {
        let code = MTag.tags[name]
        
        if code == nil {
            return false
        }
        
        return (tagCode & code!) == code!
    }
    
    @discardableResult static func addTagName(_ name: String) -> Bool {
        if tags[name] != nil {
            return false
        }
    
        // to get around 'pow' not working:
        // https://stackoverflow.com/questions/42338009/how-to-use-pow-in-swift-3-and-get-an-int
        tags[name] = Int(powf(2, Float(tags.count)))
        
        return true
    }
}
