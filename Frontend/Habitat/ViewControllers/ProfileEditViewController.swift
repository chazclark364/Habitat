//
//  ProfileEditViewController.swift
//  Habitat
//
//  Created by Travis Stanger on 10/5/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation
import UIKit

class ProfileEditViewController: UIViewController {
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var userTypeSegment: UISegmentedControl!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet var profileEditView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.isEnabled = false
        submitButton.layer.cornerRadius = 5
        submitButton.clipsToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        profileEditView.addGestureRecognizer(tap)
        getUserInfo()
    }
    
    @IBAction func pressedUpdate(_ sender: Any) {
        updateUser()
    }
    
    func getUserInfo() {
        var possibleUser: User?
        let userId = UserDefaults.standard.integer(forKey: "userID")
        HabitatAPI.UserAPI().getUserInfo(userId: userId, completion: {  user in
            possibleUser = user
            //Means the creation was succesful
            if let newUser = possibleUser {
                //Save locally
                self.saveData(user: newUser)
                self.updateDisplay()
            } else {
                //Alert with error message if anything goes wrong
                self.present(AlertViews().didNotCreateUserAlert(), animated: true)
            }
        })
    }
    
    private func updateUser() {
        let user = User()
        var possibleUser: User?
        user.firstName = firstNameField.text
        user.lastName = lastNameField.text
        user.email = emailField.text
        user.phoneNumber = phoneField.text
        user.type = getTypeValue()
        if (passwordField.text != "") {
            user.password = passwordField.text
        }
        
        /*HabitatAPI.UserAPI().updateUser(user: user, completion: {  user in
            possibleUser = user
            //Means the creation was succesful
            if let newUser = possibleUser {
                //Save locally
                self.saveData(user: newUser)
                //Segue into home view or profile view for demo 2
                self.performSegue(withIdentifier: "profileEditToProfile", sender: nil)
            } else {
                //Alert with error message if anything goes wrong
                self.present(AlertViews().didNotCreateUserAlert(), animated: true)
            }
        })*/
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
    
    func updateDisplay() {
        var firstNameString = "Loading..."
        var lastNameString = "Loading..."
        var emailString = "Loading..."
        var phoneString = "Loading..."
        var typeString = "Loading..."
        
        firstNameString = UserDefaults.standard.string(forKey: "userFirstName") ?? "Unknown"
        lastNameString = UserDefaults.standard.string(forKey: "userLastName") ?? "Unknown"
        emailString = UserDefaults.standard.string(forKey: "userEmail") ?? "Unknown"
        phoneString = UserDefaults.standard.string(forKey: "userPhoneNumber") ?? "Unknown"
        typeString = UserDefaults.standard.string(forKey: "userType") ?? "Unknown"
        typeString = typeString.prefix(1).uppercased() + typeString.dropFirst()
        
        firstNameField?.text = firstNameString
        lastNameField?.text = lastNameString
        emailField?.text = emailString
        phoneField?.text = phoneString
        userTypeSegment.selectedSegmentIndex = getSegmentIndex(type: typeString)
    }
    
    private func getSegmentIndex(type: String) -> Int {
        if (type == "Tenant") {
            return 0
        }
        else if (type == "Landlord") {
            return 1
        }
        else if (type == "Worker") {
            return 2
        }
        else {
            return 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        updateDisplayValidated()
    }
    
    func updateDisplayValidated() {
        submitButton.isEnabled = validation()
        dismissKeyboard()
    }
    
    private func validation() -> Bool {
        if (firstNameField.text == "") {
            self.present(AlertViews().enterFirstName(), animated: true)
        }
        if (lastNameField.text == "") {
            self.present(AlertViews().enterLastName(), animated: true)
        }
        if (emailField.text == "") {
            self.present(AlertViews().enterEmail(), animated: true)
        }
        if (emailField.text?.contains("@") == false || emailField.text?.contains(".") == false) {
            self.present(AlertViews().invalidEmail(), animated:  true)
        }
        if (passwordField.text == "") {
            self.present(AlertViews().enterPassword(), animated: true)
        }
        if (phoneField.text == "") {
            self.present(AlertViews().enterPhoneNumber(), animated: true)
        }
        if (phoneField.text?.count ?? 0 > 10) {
            self.present(AlertViews().phoneNumberTooLong(), animated:  true)
        }
        if (phoneField.text?.count ?? 0 < 10) {
            self.present(AlertViews().phoneNumberTooShort(), animated:  true)
        }
        if(firstNameField.text != "" && lastNameField.text != "" && emailField.text != "" && phoneField.text != "" && phoneField.text?.count == 10 && passwordField.text != "") {
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
}

extension ProfileEditViewController {
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
