//
//  ViewController.swift
//  ExperimentalCode
//
//  Created by Travis Stanger on 9/5/18.
//  Copyright © 2018 Travis Stanger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var button = UIButton()
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var loginLabel: UILabel!
    
    
    @IBAction func pressedLogin(_ sender: Any) {
        
        loginLabel.isHidden = !loginLabel.isHidden
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loginLabel.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

