//
//  TabViewController.swift
//  Habitat
//
//  Created by Travis Stanger on 11/7/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation
import UIKit

class TabViewController: UIViewController {
    //TODO: Construct a user object
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.performSegue(withIdentifier: "tabToProfile", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

