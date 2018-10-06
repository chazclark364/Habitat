//
//  ProfileViewController.swift
//  Habitat
//
//  Created by Chaz Clark on 9/24/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var backgroundTop: UIView!
    @IBOutlet weak var backgroundBottom: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        backgroundBottom.layer.cornerRadius = 24
        backgroundBottom.clipsToBounds = true
        backgroundTop.layer.cornerRadius = 24
        backgroundTop.clipsToBounds = true
        profileImage.layer.cornerRadius = 24
        profileImage.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
