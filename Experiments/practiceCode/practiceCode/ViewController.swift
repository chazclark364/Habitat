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
    var redVal: CGFloat = 1
    var greenVal: CGFloat = 1
    var blueVal: CGFloat = 1
    
    @IBAction func pressedLogin(_ sender: Any) {
        loginLabel.isHidden = !loginLabel.isHidden
    }
    
    @IBAction func redValue(_ sender: Any) {
        redVal = CGFloat(redSlider.value / 255)
        self.view.backgroundColor = UIColor(red: redVal, green: greenVal, blue: blueVal, alpha: 1)
        redSlider.thumbTintColor = UIColor(red: redVal, green: 0, blue: 0, alpha: 1)
    }
    
    @IBAction func greenValue(_ sender: Any) {
        greenVal = CGFloat(greenSlider.value / 255)
        self.view.backgroundColor = UIColor(red: redVal, green: greenVal, blue: blueVal, alpha: 1)
        greenSlider.thumbTintColor = UIColor(red: 0, green: greenVal, blue: 0, alpha: 1)
    }
    
    @IBAction func blueValue(_ sender: Any) {
        blueVal = CGFloat(blueSlider.value / 255)
        self.view.backgroundColor = UIColor(red: redVal, green: greenVal, blue: blueVal, alpha: 1)
        blueSlider.thumbTintColor = UIColor(red: 0, green: 0, blue: blueVal, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loginLabel.isHidden = true
        self.view.backgroundColor = UIColor(red: redVal, green: greenVal, blue: blueVal, alpha: 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
