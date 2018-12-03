//
//  PropertyUpdateViewController.swift
//  Habitat
//
//  Created by Travis Stanger on 12/2/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation
import UIKit

class PropertyUpdateViewController: UIViewController {
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var rentDueTextField: UITextField!
    @IBOutlet weak var statusSegmentControl: UISegmentedControl!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (UserDefaults.standard.bool(forKey: "darkMode")) {
            view.backgroundColor = #colorLiteral(red: 0.1568627451, green: 0.1568627451, blue: 0.2352941176, alpha: 1)
            saveButton.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.3529411765, alpha: 1)
            cancelButton.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.3529411765, alpha: 1)
        }
        else {
            view.backgroundColor = #colorLiteral(red: 1, green: 0.7294117647, blue: 0.3607843137, alpha: 1)
            saveButton.backgroundColor = #colorLiteral(red: 1, green: 0.7916666667, blue: 0.5, alpha: 1)
            cancelButton.backgroundColor = #colorLiteral(red: 1, green: 0.7916666667, blue: 0.5, alpha: 1)
        }
        
        if (UserDefaults.standard.string(forKey: "selectedPropertyStatus") == "Occupied") {
            statusSegmentControl.selectedSegmentIndex = 1
        }
        if (UserDefaults.standard.string(forKey: "selectedPropertyAddress") != nil) {
            addressTextField.text = UserDefaults.standard.string(forKey: "selectedPropertyAddress")
        }
        if (UserDefaults.standard.string(forKey: "selectedPropertyDueDate") != nil) {
            rentDueTextField.text = UserDefaults.standard.string(forKey: "selectedPropertyDueDate")
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
