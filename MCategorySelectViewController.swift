//
//  MCategorySelectViewController.swift
//  ViewMasterSwift
//
//  Created by Brendan Thompson on 4/16/18.
//  Copyright © 2018 Robert England. All rights reserved.
//

import UIKit

class MCategorySelectViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // ===============================================
    // Handle Category Selection
    // ===============================================
    @IBAction func category19th(_ sender: Any) {
        navigateToCatalog(category: 1)
    }
    
    @IBAction func category20th(_ sender: Any) {
        navigateToCatalog(category: 2)
    }
    
    @IBAction func anatomicalSpecimen(_ sender: Any) {
        navigateToCatalog(category: 3)
    }
    
    @IBAction func categoryButts(_ sender: Any) {
        navigateToCatalog(category: 4)
    }
    
    // Navigate to the MTabBarController given the selected category
    func navigateToCatalog(category: Int){
        
        // Create New MTabBarController
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let tempViewController = storyBoard.instantiateViewController(withIdentifier: "catalogTabBarController") as! MTabBarController
        tempViewController.selectedCategory = category
        
        // Navigate to new MTabBarController
        // navigation = https://makeapppie.com/2016/06/30/adding-modal-views-and-popovers-in-swift-3-0/
//        tempViewController.modalTransitionStyle = .crossDissolve
        present(tempViewController, animated: true, completion: nil)
    }
    
}
