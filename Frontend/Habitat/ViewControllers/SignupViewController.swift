//
//  SignupViewController.swift
//  Habitat
//
//  Created by Travis Stanger on 9/26/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation
import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var fNameTextField: UITextField!
    @IBOutlet weak var lNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordField: UITextField!
    @IBOutlet weak var pNumberTextField: UITextField!
    @IBOutlet weak var userTypeSegment: UISegmentedControl!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet var signUpView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.cornerRadius = 5
        submitButton.clipsToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        signUpView.addGestureRecognizer(tap)
    }
    
    @IBAction func pressedSubmit(_ sender: Any) {
        checkEntries()
        if(validation()) {
            createUser()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
       updateDisplay()
    }
    
    func updateDisplay() {
        dismissKeyboard()
    }
    
    //Returns true if all fields are filled out appropiatley
    private func validation() -> Bool {
        if(fNameTextField.text != "" && lNameTextField.text != "" && emailTextField.text != "" && pNumberTextField.text != "" && pNumberTextField.text?.count == 10 && passwordTextField.text != "" && passwordTextField.text == rePasswordField.text) {
            return true
        }
        return false
    }
    
    private func checkEntries() {
        var msgStr = ""
        if (fNameTextField.text == "") {
            msgStr = "Please enter a first name."
        }
        if (lNameTextField.text == "") {
            msgStr = "Please enter a last name."
        }
        if (emailTextField.text == "") {
            msgStr = "Please enter an email address."
        }
        if (emailTextField.text?.contains("@") == false || emailTextField.text?.contains(".") == false) {
            msgStr = "Please enter a valid email address."
        }
        if (passwordTextField.text == "") {
            msgStr = "Please enter a password."
        }
        if (rePasswordField.text == "") {
            msgStr = "Please re-enter your password."
        }
        if (passwordTextField.text != rePasswordField.text) {
            msgStr = "Passwords do not match."
        }
        if (pNumberTextField.text == "") {
            msgStr = "Please enter a phone number."
        }
        if (pNumberTextField.text?.count ?? 0 > 10) {
            msgStr = "Please verify that your phone number is correct."
        }
        if (pNumberTextField.text?.count ?? 0 < 10) {
            msgStr = "Please include an area code on your phone number."
        }
        if (!(CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: pNumberTextField.text ?? "Error")))) {
            msgStr = "Please only enter numbers for your phone number."
        }

        if (msgStr != "") {
            self.present(AlertViews().errorAlert(msg: msgStr), animated: true)
        }
    }
    
    private func getTypeValue() -> String {
        switch userTypeSegment.selectedSegmentIndex {
        case 0:
            return "Tenant"
        case 1:
            return "Landlord"
        case 2:
            return "Worker"
        default:
            return "Tenant"
        }
    }
    
    private func createUser() {
        let user = User()
        var possibleUser: User?
        user.firstName = fNameTextField.text
        user.lastName = lNameTextField.text
        user.email = emailTextField.text
        user.phoneNumber = pNumberTextField.text
        user.type = getTypeValue()
        user.password = passwordTextField.text

         HabitatAPI.UserAPI().createUser(user: user, completion: {  user in
           possibleUser = user
            //Means the creation was succesful
            if let newUser = possibleUser {
                //Save locally
                newUser.password = self.passwordTextField.text
                self.saveData(user: newUser)
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                self.performSegue(withIdentifier: "signUpToHome", sender: nil)
            } else {
                //Alert with error message if anything goes wrong
                self.present(AlertViews().errorAlert(msg: "Could not sign up user."), animated: true)
            }
        })
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
        savedData.set(passwordTextField.text, forKey: "password")
        UserDefaults.standard.synchronize()
    }
}

extension SignupViewController {
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
