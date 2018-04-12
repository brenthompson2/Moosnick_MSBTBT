//
//  HomeViewController.swift
//  ViewMasterSwift
//
//  Created by Megan Schandel on 4/11/18.
//  Copyright © 2018 Robert England. All rights reserved.
//
//  Description: VIEW: Sets up the view of the home screen

//  Currently flips the orientation of the button images (????)

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var VirtualTourButton: UIButton!
    @IBOutlet weak var ViewCatalogButton: UIButton!
    @IBOutlet weak var MoosnickImage: UIImageView!
    @IBOutlet weak var DisplayCabinetImage: UIImageView!
    @IBOutlet weak var MedicalStuffImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DisplayCabinetImage.layer.cornerRadius = 10
        MedicalStuffImage.layer.cornerRadius = 10
        
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