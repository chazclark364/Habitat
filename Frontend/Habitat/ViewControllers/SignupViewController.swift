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
            return "Tenant"
        case 1:
            return "Landlord"
        case 3:
            return "Service"
        default:
            return "Tenant"
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        <#code#>
    }
    
    private func createUser() {
        var user = User()
        var possibleUserID: Int?
        user.firstName = fNameTextField.text
        user.lastName = lNameTextField.text
        user.email = emailTextField.text
        user.phoneNumber = pNumberTextField.text
        user.type = getTypeValue()
        user.password = passwordTextField.text
        
        
        possibleUserID = UserAPI().createUser(user: user)
        //Means the creation was succesful
        if let userID = possibleUserID {
            if userID != -1 {
                user.userId = userID
    
                //Save locally
                saveData(user: user)
                
                //Segue into home view or profile view for demo 2
                
                
            }
        }
        
        
    }
    
    
    func saveData(user: User) {
        let savedData = UserDefaults.standard
        savedData.set(user.firstName, forKey: "userFirstName")
        savedData.set(user.lastName, forKey:"userLastName")
        savedData.set(user.email, forKey: "userEmail")
        savedData.set(user.phoneNumber, forKey: "userPhoneNumber")
        savedData.set(user.type, forKey: "userType")
    }
}

extension SignupViewController {
    @IBAction func signIn(_ segue: UIStoryboardSegue) { }
}

