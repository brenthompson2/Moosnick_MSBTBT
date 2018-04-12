//
//  MCabinetViewController.swift
//  ViewMasterSwift
//
//  Created by Brendan Thompson on 4/11/18.
//  Copyright © 2018 Robert England. All rights reserved.
//
//
//

/*
    Creating Cabinet Collection View
        https://medium.com/yay-its-erica/creating-a-collection-view-swift-3-77da2898bb7c
 
    1) Create new UIViewController
    2) Add Collection View
        - default background
    3) Add ImageView
        - cabinetBackground.jpg
    4) Create MCabinetViewController: UIViewController, UICollectionViewDataSource
    5) Set dataSource to CabinetViewController
        - right click on Cabinet Collection in ViewInspector
    6) Set Controller for Collection View Cell to MCollectionViewCell
    7) Add UIImageView to CollectionViewCell
        - link to code
 
 
 
 
 
 */

import UIKit

class MCabinetViewController: UIViewController, UICollectionViewDataSource {
    var dataSource : MCabinetCollectionDataSourceProtocol? {
        didSet {
            
            // Set the title and tab bar images from the dataSource object
            // They have to be there because of the VMRPacketDataSourceProtocol
            self.title = self.dataSource!.name
            self.tabBarItem.image = self.dataSource!.tabBarImage
            
            // Set the long name shown in the navigation bar
            self.navigationItem.title = self.dataSource!.navigationBarName
            
        }
    }
    
    @IBOutlet weak var cabinetCollection: UICollectionView! // The Collection
    
    
    // Constructor
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = MCabinetCollectionDataSource()
        
        // Create a custom navigation bar button and set it to always say "Back"
        let tempBarButtonItem = UIBarButtonItem()
        tempBarButtonItem.title = "Back"
        self.navigationItem.backBarButtonItem = tempBarButtonItem
        
        print("viewDidLoad")
    }

    // Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Number of items in the section is the number of packets
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("numberOfItemsInSection: \(MArtifactArchive.artifacts.count)")
        return MArtifactArchive.artifacts.count
    }
    
    // Just one section in the grid
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        print("numberOfSectionsInCollectionView")
        return 1
    }
    
    // Return a cell for the corresponding index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MCabinetCollectionViewCell", for: indexPath as IndexPath) as! MCabinetCollectionViewCell
        
        // Set the packet for this cell as indicated by the datasource
        cell.artifact = artifactForIndexPath(indexPath: indexPath as NSIndexPath)
        cell.setNeedsDisplay()
        return cell
    }
    
    // Return the packet for the given index path (--> Take a closer look at this!)
    func artifactForIndexPath(indexPath: NSIndexPath) -> MArtifact {
        return MArtifactArchive.artifacts[indexPath.row]
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
