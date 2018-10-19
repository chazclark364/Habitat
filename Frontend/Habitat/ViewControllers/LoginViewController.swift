//
//  LoginViewController.swift
//  Habitat
//
//  Created by Travis Stanger on 9/26/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var loginView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        loginButton.isEnabled = validation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        updateDisplay()
    }
    
    private func validation() -> Bool {
        if(emailTextField.text != "" && passwordTextField.text != "") {
            return true
        }
        return false
    }
    
    func updateDisplay() {
        loginButton.isEnabled = validation()
        dismissKeyboard()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        //or
        //self.view.endEditing(true)
        return true
    }
    
    func saveData(user: User) {
        /*Programming note: saveData is just referencing UserDefaults.standard
         it is not creating a newobject everytime function is called
         */
        let savedData = UserDefaults.standard
        savedData.set(user.firstName, forKey: "userFirstName")
        savedData.set(user.lastName, forKey:"userLastName")
        savedData.set(user.email, forKey: "userEmail")
        savedData.set(user.phoneNumber, forKey: "userPhoneNumber")
        savedData.set(user.type, forKey: "userType")
        savedData.set(user.userId, forKey: "userID")
    }
    
    @IBAction func didPressLogin(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            HabitatAPI.UserAPI().loginUser(email: email, password: password, completion: {  user in
                if let userReturned = user {
                    self.saveData(user: userReturned)
                    self.performSegue(withIdentifier: "loginToHome", sender: nil)
                    //segue
                } else {
                    //alert user wrong credentials
                    if ((email.contains("@") == false) || (email.contains(".") == false)) {
                        self.present(AlertViews().invalidEmail(), animated: true)
                    }
                    else {
                        self.present(AlertViews().didNotLogin(), animated: true)
                    }
                }
            })
        }
    }
}

extension LoginViewController {
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
