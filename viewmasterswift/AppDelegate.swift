//
//  AppDelegate.swift
//  Moosnick Museum
//
//  Created by Robert England on 3/11/18 for ViewMasterSwift
//  Copyright (c) 2018 Robert England. All rights reserved.
//
//    Shamelessly plaigerized, as much as possible, from an original Apple
//       Objective-C example project called "The Elements" and its third party
//       translation into Swift
//
//    As of 2018_03_24: Swift version 1.0
//       It runs! But:
//          - No data persistence. Everything is crammed into a plist in the Supporting Files folder.
//          - It's not well formatted for the iPad screen. It's still in its original iPhone layout design.
//          - It makes a one-way, deadend trip to eBay. BUT the latest versions of iOS provide a back button
//             to the app automatically, glory hallelujah.
//          - The documentation of the source code is attrocious. Hideous and inexecusable. This will be the next
//             issue addressed.
//
//    https://developer.apple.com/library/content/samplecode/TheElements/Introduction/Intro.html
//    https://github.com/ooper-shlab/TheElements-Swift
//

import UIKit

@UIApplicationMain
@objc(AppDelegate)
//class AppDelegate: UIResponder, UIApplicationDelegate {
class AppDelegate: NSObject, UIApplicationDelegate {

    var window: UIWindow?

    
//    private func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // print("Hello?")
        let packets = VMRViewMasterPackets.sharedViewMasterPackets()
   /**/
/*        if packets != nil {
            print("Success in AppDelegate --- found the plist")
        }
        else {
            print("Problems reading plist")
        }
        print("Here's the categories: \(VMRViewMasterPackets.packetCategories)")
        let aCategory = "SHOWTIME"
        print("Here's a categories dictionary entry: \(VMRViewMasterPackets.categoriesDictionary![aCategory])")
        print("Here's the whole categories dictionary: \(VMRViewMasterPackets.categoriesDictionary!)")
        let aLetter = "B"
        print("Here's the B first letter dictionary: \(VMRViewMasterPackets.titlesIndexDictionary![aLetter])")
        print("Here's the packets sorted by number: \(VMRViewMasterPackets.packetsSortedByNumber!)")
*/
        
//// Start REAL implementation...
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

