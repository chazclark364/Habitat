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
        submitButton.isEnabled = false
        submitButton.layer.cornerRadius = 5
        submitButton.clipsToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        signUpView.addGestureRecognizer(tap)
    }
    
    @IBAction func pressedSubmit(_ sender: Any) {
        createUser()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
       updateDisplay()
    }
    
    func updateDisplay() {
        submitButton.isEnabled = validation()
        dismissKeyboard()
    }
    
    //Returns true if all fields are filled out appropiatley
    private func validation() -> Bool {
        if(fNameTextField.text != "" && lNameTextField.text != "" && emailTextField.text != "" && pNumberTextField.text != "") {
            if(passwordTextField.text != "" && (passwordTextField.text == rePasswordField.text)) {
                return true
            }
        }
        return false
    }
    
    private func getTypeValue() -> String {
        switch userTypeSegment.selectedSegmentIndex {
        case 0:
            return "tenant"
        case 1:
            return "landlord"
        case 2:
            return "worker"
        default:
            return "tenant"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
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

        possibleUser = HabitatAPI.UserAPI().createUser(user: user)
        //Means the creation was succesful
        if let newUser = possibleUser {
            //Save locally
            saveData(user: newUser)
            
            //Segue into home view or profile view for demo 2
            
            
        } else {
            //Alert with error message if anything goes wrong
            self.present(AlertViews().didNotCreateUserAlert(), animated: true)
        }
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
}

extension SignupViewController {
    @IBAction func signIn(_ segue: UIStoryboardSegue) { }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

