//
//  FinancialViewController.swift
//  Habitat
//
//  Created by Chaz Clark on 9/24/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation
import UIKit

class FinancialViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (UserDefaults.standard.bool(forKey: "darkMode")) {
            view.backgroundColor = #colorLiteral(red: 0.1568627451, green: 0.1568627451, blue: 0.2352941176, alpha: 1)
        }
        else {
            view.backgroundColor = #colorLiteral(red: 1, green: 0.7294117647, blue: 0.3607843137, alpha: 1)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
