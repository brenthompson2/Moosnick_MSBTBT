//
//  MTableViewController.swift
//  ViewMasterSwift
//
//  Created by Brendan Thompson on 3/30/18.
//  Copyright © 2018 Robert England. All rights reserved.
//

import UIKit

@objc(MTableViewController)
class MTableViewController: UITableViewController {
    
    // ======================
    // Data Source
    // ======================
    
    var dataSource : MTableViewDataSourceProtocol? {
        didSet {
            // Set the title and tab bar images from the dataSource object
            // They have to be there because of the VMRPacketDataSourceProtocol
            self.title = self.dataSource!.name
            self.tabBarItem.image = self.dataSource!.tabBarImage
            
            // Set the long name shown in the navigation bar
            self.navigationItem.title = self.dataSource!.navigationBarName
            
        }
    }
    
    // ======================
    // Constructors
    // ======================
    
    required init (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designInterface()
        
        //MArtifactArchive.loadArtifactsFromPlist()
        
        // [From doc:] "The number of table rows at which to display the index list on the right edge of the table."
        self.tableView.sectionIndexMinimumDisplayRowCount = 0
        self.tableView.delegate = self
        self.tableView.dataSource = self.dataSource
        
        // Create a custom navigation bar button and set it to always say "Catalog"
        let tempBarButtonItem = UIBarButtonItem()
        tempBarButtonItem.title = "Catalog"
        self.navigationItem.backBarButtonItem = tempBarButtonItem
        
    }
    
    
    // [Next method: In TheElements, but not in the template...]
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Force the tableview to reload
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // ======================
    // Table View Design
    // ======================
    
    // set the height of each row
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat
        height = 275
        return height
    }
    
    // Table Background
    func designInterface(){
        // Set Background = https://stackoverflow.com/questions/36384060/design-uitableview-background-image
        let bgView = UIImageView(frame: tableView.bounds)
        bgView.image = UIImage(named: "woodBackground.jpg")
        tableView.backgroundView = bgView
    }
    
    // ======================
    // Design Section Headers
    // ======================
    
    // Section Header Background
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.black
//        return headerView
//    }
    
    // Section Header Text = https://stackoverflow.com/questions/31381762/swift-ios-8-change-font-title-of-section-in-a-tableview
//    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        let header = view as? UITableViewHeaderFooterView
//        header?.textLabel?.font = UIFont(name: "Futura", size: 12) // change it according to ur requirement
//        header?.textLabel?.textColor = UIColor.white // change it according to ur requirement
//    }
    
    // Section Header Height
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 44
    }
    
    // ======================
    // Navigation
    // ======================
    
    // Return to Homescreen
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Google: "swift prepareforsegue"
    //https://stackoverflow.com/questions/44790918/swift-prepareforsegue-not-working
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            //            let selectedIndexPath = tableView.indexPathForSelectedRow()
            let selectedIndexPath = tableView.indexPathForSelectedRow
            // Find the corresponding view controller
            let aPacket = dataSource!.artifactForindexPath(indexPath: selectedIndexPath! as NSIndexPath)
            let viewController: MArtifactViewController? = segue.destination as? MArtifactViewController
            
            if viewController != nil {
                // Hide the bottom tab bar when we push this new view controller
                viewController!.hidesBottomBarWhenPushed = true
                
                // Pass the packet to this view controller
                viewController!.myArtifact = aPacket
            }
        }
    }
}
