//
//  HomeViewController.swift
//  Habitat
//
//  Created by Max Minard on 9/10/18.
//  Copyright © 2018 Max Minard. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
   
    @IBOutlet weak var TypingText: UITextField!
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var Welcome: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Label.text = "Type whatever you want!";
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func changeText(_ sender: UIButton) {
        Label.text = TypingText.text;
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
