//
//  MCabinetPageViewController.swift
//  ViewMasterSwift
//
//  Created by Brendan Thompson on 4/13/18.
//  Copyright © 2018 Robert England. All rights reserved.
//

import UIKit

class MCabinetPageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // The class for the data source is not important, but it must implement the
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var tempViewControllers = [UINavigationController]()
        
        // ======================================
        // Create Pages
        // ======================================
        let numPages = 5
        
//        for _ in 0..<numPages{
            // Instantiate a Page
            var tempNavController = storyBoard.instantiateViewController(withIdentifier: "navForCabinet") as! UINavigationController
            var tempViewController = tempNavController.topViewController! as! MCabinetViewController
            tempViewController.dataSource = MCabinetCollectionDataSource()
            tempViewControllers.append(tempNavController)
            
//        }
        
        setViewControllers(tempViewControllers, direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
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
