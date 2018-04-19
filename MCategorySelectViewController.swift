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


    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func setSection(_ sender: UIButton) {
        // Use of ?? operator: Saw it on the internet many times while researching other option-related stuff. If the optional can't be unwrapped, the value after the question marks is used instead!
        MArtifactArchive.filterSection = sender.titleLabel?.text ?? "All"
    }
    
    
    /*// Navigate to the MTabBarController given the selected category
    func navigateToCatalog(category: Int){
        
        MArtifactArchive.sortAlphabetic()
        MArtifactArchive.sortByCategory()
        
        // Create New MTabBarController
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let tempViewController = storyBoard.instantiateViewController(withIdentifier: "catalogTabBarController") as! MTabBarController
        
        // Navigate to new MTabBarController
        // navigation = https://makeapppie.com/2016/06/30/adding-modal-views-and-popovers-in-swift-3-0/
//        tempViewController.modalTransitionStyle = .crossDissolve
        present(tempViewController, animated: true, completion: nil)
    }*/
    
}
