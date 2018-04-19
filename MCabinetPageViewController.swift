//
//  MCabinetPageViewController.swift
//  ViewMasterSwift
//
//  Created by Brendan Thompson on 4/13/18.
//  Copyright © 2018 Robert England. All rights reserved.
//
//  Manages which cabinets are shown
//  Example PageViewController instantiating one view: https://gist.github.com/andreif/3bace9961c7e70995856
//
//

import UIKit

class MCabinetPageViewController: UIPageViewController {
    
    // ====================================
    // Properties
    // ====================================
    
    // Page Management
    var numPages: Int!
    var currentPageIndex: Int = 0

    // ====================================
    // Constructors
    // ====================================
    
    // View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        self.isDoubleSided = false
        dataSource = self
        numPages = MArtifactArchive.artifactsByLocation.count
        
        // Create First Page
        currentPageIndex = 0
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let tempViewController = storyBoard.instantiateViewController(withIdentifier: "cabinetView") as! MCabinetViewController
        tempViewController.dataSource = MCabinetCollectionDataSource()
        setViewControllers([getViewController(index: currentPageIndex)], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
    }

    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // ====================================
    // Manage Pages
    // ====================================
    
    // Returns an MCabinetViewController for the selected index
    func getViewController(index: Int) -> MCabinetViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let tempViewController = storyBoard.instantiateViewController(withIdentifier: "cabinetView") as! MCabinetViewController

        // Dont set pageIndex if not valid index
        if (numPages == 0) || (index >= numPages) {
            return tempViewController
        }
        
        tempViewController.pageIndex = index
        return tempViewController
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

// ====================================
// UIPageViewControllerDataSource for the cabinet
// ====================================

// Example PageViewController = https://gist.github.com/andreif/3bace9961c7e70995856
extension MCabinetPageViewController: UIPageViewControllerDataSource {
    
    // Get Previous Page
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if (currentPageIndex == 0 || currentPageIndex == NSNotFound) {
            return nil
        }
        currentPageIndex = currentPageIndex - 1
        return getViewController(index: currentPageIndex)
    }

    // Get Next Page
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if (currentPageIndex == (numPages - 1) || currentPageIndex == NSNotFound) {
            return nil
        }
        currentPageIndex = currentPageIndex + 1
        return getViewController(index: currentPageIndex)
    }

    // Get Num Pages
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return numPages
    }

    // ?
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

}

