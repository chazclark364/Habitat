//
//  ViewController.swift
//  Habitat
//
//  Created by Max Minard on 9/9/18.
//  Copyright © 2018 Max Minard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var UITextField: UITextField!
    @IBOutlet weak var UILabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func UIButton(_ sender: UIButton) {
        
        UILabel.text = UITextField.text;
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

