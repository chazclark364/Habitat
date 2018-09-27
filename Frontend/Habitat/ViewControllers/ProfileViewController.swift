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
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    
    @IBOutlet weak var userNameValueLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
