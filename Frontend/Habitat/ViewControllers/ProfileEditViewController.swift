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
    @IBOutlet weak var buttonSelectLandlord: UIButton!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var userTypeSegment: UISegmentedControl!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet var profileEditView: UIView!
    @IBOutlet weak var mutableLabel: UILabel!
    @IBOutlet weak var mutableField: UITextField!
    @IBOutlet weak var landlordNameLabel: UILabel!
    
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
        updateUserInfo()
    }
    
    @IBAction func typeChange(_ sender: Any) {
        if (userTypeSegment.selectedSegmentIndex == 0) {
            buttonSelectLandlord.isHidden = false
            mutableLabel.text = "Landlord"
            mutableField.isHidden = true
            landlordNameLabel.text = UserDefaults.standard.string(forKey: "landlordName") ?? "Not Selected"
            landlordNameLabel.isHidden = false
            
        }
        else if (userTypeSegment.selectedSegmentIndex == 1){
            buttonSelectLandlord.isHidden = true
            mutableField.isHidden = false
            mutableLabel.text = "Address"
            landlordNameLabel.text = ""
            landlordNameLabel.isHidden = true
        }
        else {
            buttonSelectLandlord.isHidden = true
            mutableField.isHidden = false
            mutableLabel.text = "Company"
            landlordNameLabel.text = ""
            landlordNameLabel.isHidden = true
            
        }
    }
    
    func getUserInfo() {
        var possibleUser: User?
        let userId = UserDefaults.standard.integer(forKey: "userID")
        HabitatAPI.UserAPI().getUserInfo(userId: userId, completion: {  user in
            possibleUser = user
            //Means the creation was succesful
            if let newUser = possibleUser {
                //Save locally
                newUser.password = UserDefaults.standard.string(forKey: "password")
                self.saveData(user: newUser)
                self.updateDisplay()
            } else {
                //Alert with error message if anything goes wrong
                self.present(AlertViews().errorAlert(msg: "Could not create user."), animated: true)
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
        savedData.set(user.password, forKey: "password")
    }
    
    private func updateUserInfo() {
        let user = User()
        let userId = UserDefaults.standard.integer(forKey: "userID")
        let pWord = UserDefaults.standard.string(forKey: "password")
        var possibleUser: User?
        user.firstName = firstNameField.text
        user.lastName = lastNameField.text
        user.phoneNumber = phoneField.text
        user.type = getTypeValue()
        user.email = emailField.text
        user.userId = userId
        user.password = pWord
        
        if (user.type == "Landlord") {
          //  updateLandlord(id: user.userId ?? 0)
        }
        else if (user.type == "Worker") {
          //  updateWorker(id: user.userId ?? 0)
        }
        
        HabitatAPI.UserAPI().updateUserInfo(user: user, completion: {  user in
            possibleUser = user
            if let updateUser = possibleUser {
                updateUser.password = UserDefaults.standard.string(forKey: "password")
                self.saveData(user: updateUser)
                //self.present(AlertViews().updateAlert(msg: "User information updated successfully.", identifier: "editProfileToProfile"), animated: true)
                self.performSegue(withIdentifier:
                    "editProfileToProfile", sender: nil)

            } else {
                self.present(AlertViews().errorAlert(msg: "Could not update information."), animated: true)
            }
        })
    }

//    func updateLandlord(id: Int) {
//        let landlord = Landlord()
//        var possibleLandlord: Landlord?
//        landlord.landlordId = id
//        landlord.address = mutableField.text
//        HabitatAPI.UserAPI().updateLandlord(landlord: landlord, completion: { landlord in
//            possibleLandlord = landlord
//            if let updateLandlord = possibleLandlord {
//                UserDefaults.standard.set(updateLandlord.address, forKey: "landlordAddress")
//                UserDefaults.standard.synchronize()
//            }
//            else {
//                self.present(AlertViews().errorAlert(msg: "Could not update information."), animated: true)
//            }
//        })
//    }
    
//    func updateWorker(id: Int) {
//        let worker = Worker()
//        var possibleWorker: Worker?
//        worker.workerId = id
//        worker.company = mutableField.text
//        HabitatAPI.UserAPI().updateWorker(worker: worker, completion: { worker in
//            possibleWorker = worker
//            if let updateWorker = possibleWorker {
//                UserDefaults.standard.set(updateWorker.company, forKey: "workerCompany")
//                UserDefaults.standard.synchronize()
//            }
//            else {
//                self.present(AlertViews().errorAlert(msg: "Could not update information."), animated: true)
//            }
//        })
//    }
    
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
        if (userTypeSegment.selectedSegmentIndex == 0) {
            buttonSelectLandlord.isHidden = false
            mutableLabel.text = "Landlord"
            mutableField.isHidden = true
            landlordNameLabel.text = UserDefaults.standard.string(forKey: "landlordName") ?? "Not Selected"
            landlordNameLabel.isHidden = false
        }
        else if (userTypeSegment.selectedSegmentIndex == 1){
            buttonSelectLandlord.isHidden = true
            mutableField.isHidden = false
            mutableLabel.text = "Address"
            landlordNameLabel.text = ""
            landlordNameLabel.isHidden = true
        }
        else {
            buttonSelectLandlord.isHidden = true
            mutableField.isHidden = false
            mutableLabel.text = "Company"
            landlordNameLabel.text = ""
            landlordNameLabel.isHidden = true
        }
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
        var msgStr = ""
        if (firstNameField.text == "") {
            msgStr = "Please enter a first name."
        }
        if (lastNameField.text == "") {
            msgStr = "Please enter a last name."
        }
        if (emailField.text == "") {
            msgStr = "Please enter an email address."
        }
        if (emailField.text?.contains("@") == false || emailField.text?.contains(".") == false) {
            msgStr = "Please enter a valid email address."
        }
        if (phoneField.text == "") {
            msgStr = "Please enter a phone number."
        }
        if (phoneField.text?.count ?? 0 > 10) {
            msgStr = "Please verify that your phone number is correct."
        }
        if (phoneField.text?.count ?? 0 < 10) {
            msgStr = "Please include an area code on your phone number."
        }
        if (!(CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: phoneField.text ?? "Error")))) {
            msgStr = "Please only enter numbers for your phone number."
        }
        if(firstNameField.text != "" && lastNameField.text != "" && emailField.text != "" && phoneField.text != "" && phoneField.text?.count == 10) {
            submitButton.isEnabled = true
            return true
        }
        self.present(AlertViews().errorAlert(msg: msgStr), animated: true)
        submitButton.isEnabled = false
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
