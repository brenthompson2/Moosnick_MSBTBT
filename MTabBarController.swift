//
//  MTabBarController.swift
//  ViewMasterSwift
//
//  Created by Brendan Thompson on 4/6/18.
//  Copyright © 2018 Robert England. All rights reserved.
//

import UIKit

class MTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For each table view screen we need to create a separate data source instance
        // We then need to create an instance of VMRPacketsTableViewCOntroller with that data source instance.
        // Finally, we need to return a UINavigationController for each screen, with the MArtifactViewController
        //    as its root view controller
//        let tabBarController = self.window?.rootViewController as! UITabBarController
        
        // The class for the data source is not important, but it must implement the
        //    VMRPacketDataSourceProtocol (...and the UITableViewDataSource protocol, too?)
        var _ : MTableViewDataSourceProtocol
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var tempViewControllers = [UIViewController]()
        
        // Now create our tab bar view controllers.
        // Since we already have one defined in the storyboard, we will create as many instances of it
        //    as we need for the different ways of display, and assign each its own data source.
        
        // Sorted by title...
        var tempViewController = storyBoard.instantiateViewController(withIdentifier: "catalogTableView") as! MTableViewController
        tempViewController.dataSource = MTitleDataSource()
        tempViewControllers.append(tempViewController)
        
        /* //Sorted by number...
        tempNavController = storyBoard.instantiateViewController(withIdentifier: "navForTableView") as! UINavigationController
        tempViewController = tempNavController.topViewController! as! MTableViewController
        tempViewController.dataSource = MNumberDataSource()
        tempViewControllers.append(tempNavController) */
        
        // Sorted by category...
        tempViewController = storyBoard.instantiateViewController(withIdentifier: "catalogTableView") as! MTableViewController
        tempViewController.dataSource = MTagDataSource()
        tempViewControllers.append(tempViewController)
        
        // Sorted by number, as a grid...
        let tempGridViewController = storyBoard.instantiateViewController(withIdentifier: "catalogCollectionView") as! MCollectionViewController
        tempGridViewController.dataSource = MCollectionDataSource()
        tempViewControllers.append(tempGridViewController)
        // print("Got this far... Grid VC exists")
        
        // Create a custom navigation bar button and set it to always say "Back"
        let tempBarButtonItem = UIBarButtonItem()
        tempBarButtonItem.title = "Back"
        self.navigationItem.backBarButtonItem = tempBarButtonItem
        
        self.viewControllers = tempViewControllers
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
