//
//  MCategory.swift
//  ViewMasterSwift
//
//  Created by Brandon Trapp on 4/3/18.
//  Copyright © 2018 Robert England. All rights reserved.
//

import Foundation

class MCategory {
    static var categories = [String: Int]()
    
    var categoryCode = 0
    
    var isUncategorized: Bool { return categoryCode == 0 }
    
    @discardableResult func setCategory(_ name: String) -> Bool {
        if hasCategory(name) {
            return false
        }
        
        var code = MCategory.categories[name]
        
        if code == nil {
            MCategory.addCategoryName(name)
            code = MCategory.categories[name]
        }
        
        categoryCode = categoryCode + code!
        
        return true
    }
    
    @discardableResult func removeCategory(_ name: String) -> Bool {
        if !hasCategory(name) {
            return false
        }
        
        let code = MCategory.categories[name]
        
        if code == nil {
            return false
        }
        
        categoryCode = categoryCode - code!
        
        return true
    }
    
    func hasCategory(_ name: String) -> Bool {
        let code = MCategory.categories[name]
        
        if code == nil {
            return false
        }
        
        return (categoryCode & code!) == code!
    }
    
    @discardableResult static func addCategoryName(_ name: String) -> Bool {
        if categories[name] != nil {
            return false
        }
    
        // to get around 'pow' not working:
        // https://stackoverflow.com/questions/42338009/how-to-use-pow-in-swift-3-and-get-an-int
        categories[name] = Int(powf(2, Float(categories.count)))
        
        return true
    }
}
