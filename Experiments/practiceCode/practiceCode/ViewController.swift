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
    var slider = UISlider()
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBAction func pressedLogin(_ sender: Any) {
        
        loginLabel.isHidden = !loginLabel.isHidden
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
