//
//  ViewController.swift
//  Habitat
//
//  Created by Max Minard on 9/9/18.
//  Copyright © 2018 Max Minard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var SignInLabel: UILabel!
    
    @IBOutlet weak var UsernameLabel: UILabel!
    @IBOutlet weak var UsernameText: UITextField!

    @IBOutlet weak var PasswordText: UITextField!
    @IBOutlet weak var PasswordLabel: UILabel!
    
    @IBOutlet weak var Message: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func Login(_ sender: UIButton) {
        
        Message.text = "Please Enter Login Credentials";
        
        if(UsernameText.text == "maxminard" &&
            PasswordText.text == "coms309"){
            performSegue(withIdentifier: "login", sender: self);
        }
        else{
            Message.text = "Incorrect Username or Password";
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

