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
        if (fNameTextField.text == "") {
            self.present(AlertViews().enterFirstName(), animated: true)
        }
        if (lNameTextField.text == "") {
            self.present(AlertViews().enterLastName(), animated: true)
        }
        if (emailTextField.text == "") {
            self.present(AlertViews().enterEmail(), animated: true)
        }
        if (emailTextField.text?.contains("@") == false || emailTextField.text?.contains(".") == false) {
            self.present(AlertViews().invalidEmail(), animated:  true)
        }
        if (passwordTextField.text == "") {
            self.present(AlertViews().enterPassword(), animated: true)
        }
        if (rePasswordField.text == "") {
            self.present(AlertViews().reenterPassword(), animated: true)
        }
        if (passwordTextField.text != rePasswordField.text) {
            self.present(AlertViews().passwordNoMatch(), animated:  true)
        }
        if (pNumberTextField.text == "") {
            self.present(AlertViews().enterPhoneNumber(), animated: true)
        }
        if (pNumberTextField.text?.count != 10) {
            self.present(AlertViews().phoneNumberLength(), animated:  true)
        }
        if(fNameTextField.text != "" && lNameTextField.text != "" && emailTextField.text != "" && pNumberTextField.text != "" && pNumberTextField.text?.count == 10 && passwordTextField.text != "" && passwordTextField.text == rePasswordField.text) {
            return true
        }
        return false
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

         HabitatAPI.UserAPI().createUser(user: user, completion: {  user in
           possibleUser = user
            //Means the creation was succesful
            if let newUser = possibleUser {
                //Save locally
                self.saveData(user: newUser)
                
                //Segue into home view or profile view for demo 2
                self.performSegue(withIdentifier: "signUpToProfile", sender: nil)
                
            } else {
                //Alert with error message if anything goes wrong
                self.present(AlertViews().didNotCreateUserAlert(), animated: true)
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
    }
}

extension SignupViewController {
  
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

