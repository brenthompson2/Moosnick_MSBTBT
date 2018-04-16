//
//  MCabinetPageViewController.swift
//  ViewMasterSwift
//
//  Created by Brendan Thompson on 4/13/18.
//  Copyright © 2018 Robert England. All rights reserved.
//

import UIKit

class MCabinetPageViewController: UIPageViewController {
    
    var numPages: Int = 1
    var cabinetControllers = [UINavigationController]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.isDoubleSided = false
        
        // The class for the data source is not important, but it must implement the
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        // ======================================
        // Create Pages
        // ======================================
        
//        for _ in 0..<numPages{
            // Instantiate a Page
            var tempNavController = storyBoard.instantiateViewController(withIdentifier: "navForCabinet") as! UINavigationController
            var tempViewController = tempNavController.topViewController! as! MCabinetViewController
            tempViewController.dataSource = MCabinetCollectionDataSource()
            cabinetControllers.append(tempNavController)
            setViewControllers(cabinetControllers, direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
            
//        }
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

// Example PageViewController = https://gist.github.com/andreif/3bace9961c7e70995856
//class MCabinetPageViewDataSource: UIPageViewControllerDataSource {
//    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
//        let vc = viewController as! MCabinetViewController
//        var index = vc.pageIndex as Int
//        if (index == 0 || index == NSNotFound) {
//            return nil
//        }
//        index--
//        return self.viewControllerAtIndex(index)
//    }
//
//    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
//        let vc = viewController as! MCabinetViewController
//        var index = vc.pageIndex as Int
//        if (index == NSNotFound) {
//            return nil
//        }
//        index++
//        if (index == PAGES.count) {
//            return nil
//        }
//        return self.viewControllerAtIndex(index)
//    }
//
//    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return PAGES.count
//    }
//
//    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return 0
//    }
//
//}

