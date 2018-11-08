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
    @IBOutlet weak var darkModeButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var changePassButton: UIButton!
    @IBOutlet weak var mutableField: UITextField!
    @IBOutlet weak var landlordNameLabel: UILabel!
    var selectedLandlord: Landlord?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changePassButton.isHidden = true
        if (UserDefaults.standard.bool(forKey: "darkMode")) {
            view.backgroundColor = #colorLiteral(red: 0.1568627451, green: 0.1568627451, blue: 0.2352941176, alpha: 1)
            submitButton.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.3529411765, alpha: 1)
            buttonSelectLandlord.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.3529411765, alpha: 1)
            backButton.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.3529411765, alpha: 1)
            darkModeButton.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.3529411765, alpha: 1)
            changePassButton.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.3529411765, alpha: 1)
            darkModeButton.setTitle("Light Mode", for: .normal)
        }
        else {
            view.backgroundColor = #colorLiteral(red: 1, green: 0.7294117647, blue: 0.3607843137, alpha: 1)
            submitButton.backgroundColor = #colorLiteral(red: 1, green: 0.7916666667, blue: 0.5, alpha: 1)
            buttonSelectLandlord.backgroundColor = #colorLiteral(red: 1, green: 0.7916666667, blue: 0.5, alpha: 1)
            backButton.backgroundColor = #colorLiteral(red: 1, green: 0.7916666667, blue: 0.5, alpha: 1)
            darkModeButton.backgroundColor = #colorLiteral(red: 1, green: 0.7916666667, blue: 0.5, alpha: 1)
            changePassButton.backgroundColor = #colorLiteral(red: 1, green: 0.7916666667, blue: 0.5, alpha: 1)
            darkModeButton.setTitle("Dark Mode", for: .normal)
        }
        submitButton.layer.cornerRadius = 5
        submitButton.clipsToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        profileEditView.addGestureRecognizer(tap)
        getUserInfo()
    }
    
    @IBAction func darkMode(_ sender: Any) {
        UserDefaults.standard.set(!UserDefaults.standard.bool(forKey: "darkMode"), forKey: "darkMode")
        UserDefaults.standard.synchronize()
        if (UserDefaults.standard.bool(forKey: "darkMode")) {
            view.backgroundColor = #colorLiteral(red: 0.1568627451, green: 0.1568627451, blue: 0.2352941176, alpha: 1)
            submitButton.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.3529411765, alpha: 1)
            buttonSelectLandlord.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.3529411765, alpha: 1)
            backButton.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.3529411765, alpha: 1)
            darkModeButton.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.3529411765, alpha: 1)
            changePassButton.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.3529411765, alpha: 1)
            darkModeButton.setTitle("Light Mode", for: .normal)
        }
        else {
            view.backgroundColor = #colorLiteral(red: 1, green: 0.7294117647, blue: 0.3607843137, alpha: 1)
            submitButton.backgroundColor = #colorLiteral(red: 1, green: 0.7916666667, blue: 0.5, alpha: 1)
            buttonSelectLandlord.backgroundColor = #colorLiteral(red: 1, green: 0.7916666667, blue: 0.5, alpha: 1)
            backButton.backgroundColor = #colorLiteral(red: 1, green: 0.7916666667, blue: 0.5, alpha: 1)
            darkModeButton.backgroundColor = #colorLiteral(red: 1, green: 0.7916666667, blue: 0.5, alpha: 1)
            changePassButton.backgroundColor = #colorLiteral(red: 1, green: 0.7916666667, blue: 0.5, alpha: 1)
            darkModeButton.setTitle("Dark Mode", for: .normal)
        }
    }
    
    @IBAction func pressedUpdate(_ sender: Any) {
        checkEntries()
        if (validation()) {
            updateUserInfo()
        }
    }
    
    @IBAction func typeChange(_ sender: Any) {
        if (userTypeSegment.selectedSegmentIndex == 0) {
            buttonSelectLandlord.isHidden = false
            mutableLabel.text = "Landlord"
            mutableField.isHidden = true
            landlordNameLabel.text = UserDefaults.standard.string(forKey: "landlordName") ?? "Not Selected"
            landlordNameLabel.isHidden = false
            UserDefaults.standard.set("", forKey: "landlordAddress")
            UserDefaults.standard.set("", forKey: "workerCompany")
        }
        else if (userTypeSegment.selectedSegmentIndex == 1){
            buttonSelectLandlord.isHidden = true
            mutableField.isHidden = false
            mutableLabel.text = "Address"
            landlordNameLabel.text = ""
            landlordNameLabel.isHidden = true
            UserDefaults.standard.set("", forKey: "workerCompany")
            UserDefaults.standard.set("", forKey: "tenantLandlordId")
            UserDefaults.standard.set("", forKey: "tenantResidence")
            UserDefaults.standard.set("", forKey: "tenantMonthlyRent")
        }
        else {
            buttonSelectLandlord.isHidden = true
            mutableField.isHidden = false
            mutableLabel.text = "Company"
            landlordNameLabel.text = ""
            landlordNameLabel.isHidden = true
            UserDefaults.standard.set("", forKey: "landlordAddress")
            UserDefaults.standard.set("", forKey: "tenantLandlordId")
            UserDefaults.standard.set("", forKey: "tenantResidence")
            UserDefaults.standard.set("", forKey: "tenantMonthlyRent")
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
        savedData.synchronize()
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
        
        HabitatAPI.UserAPI().updateUserInfo(user: user, completion: {  user in
            possibleUser = user
            if let updateUser = possibleUser {
                updateUser.password = UserDefaults.standard.string(forKey: "password")
                self.saveData(user: updateUser)
                //self.present(AlertViews().updateAlert(msg: "User information updated successfully.", identifier: "editProfileToProfile"), animated: true)
                if (self.getTypeValue() == "Landlord") {
                    self.updateLandlordInfo()
                }
                else if (self.getTypeValue() == "Worker") {
                    self.updateWorkerInfo()
                }
                else {
                    self.performSegue(withIdentifier: "editProfileToProfile", sender: nil)
                }
            } else {
                self.present(AlertViews().errorAlert(msg: "Could not update information."), animated: true)
            }
        })
    }
    
    func updateLandlordInfo() {
        let landlord = Landlord()
        var possibleLandlord: Landlord?
        let id = UserDefaults.standard.integer(forKey: "userID")
        landlord.address = mutableField.text
        landlord.landlordId = id
        HabitatAPI.UserAPI().updateLandlord(landlord: landlord, completion: { landlord in
            possibleLandlord = landlord
            if let updateLandlord = possibleLandlord {
                UserDefaults.standard.set(updateLandlord.address, forKey: "landlordAddress")
                UserDefaults.standard.synchronize()
                self.performSegue(withIdentifier: "editProfileToProfile", sender: nil)
            }
            else {
                self.present(AlertViews().errorAlert(msg: "Could not update information."), animated: true)
            }
        })
    }
    
    func updateWorkerInfo() {
        let worker = Worker()
        var possibleWorker: Worker?
        let id = UserDefaults.standard.integer(forKey: "userID")
        worker.company = mutableField.text
        worker.workerId = id
        HabitatAPI.UserAPI().updateWorker(worker: worker, completion: { worker in
            possibleWorker = worker
            if let updateWorker = possibleWorker {
                UserDefaults.standard.set(updateWorker.company, forKey: "workerCompany")
                UserDefaults.standard.synchronize()
                self.performSegue(withIdentifier: "editProfileToProfile", sender: nil)
            }
            else {
                self.present(AlertViews().errorAlert(msg: "Could not update information."), animated: true)
            }
        })
    }
    
    func updateDisplay() {
        var firstNameString = "Loading..."
        var lastNameString = "Loading..."
        var emailString = "Loading..."
        var phoneString = "Loading..."
        var typeString = "Loading..."
        var mutableString = "Loading..."
        
        firstNameString = UserDefaults.standard.string(forKey: "userFirstName") ?? "Unknown"
        lastNameString = UserDefaults.standard.string(forKey: "userLastName") ?? "Unknown"
        emailString = UserDefaults.standard.string(forKey: "userEmail") ?? "Unknown"
        phoneString = UserDefaults.standard.string(forKey: "userPhoneNumber") ?? "Unknown"
        typeString = UserDefaults.standard.string(forKey: "userType") ?? "Unknown"
        typeString = typeString.prefix(1).uppercased() + typeString.dropFirst()
        if (UserDefaults.standard.integer(forKey: "userID") == 1) {
            mutableString = UserDefaults.standard.string(forKey: "landlordAddress") ?? "Unknown"
        }
        else if (UserDefaults.standard.integer(forKey: "userID") == 2) {
            mutableString = UserDefaults.standard.string(forKey: "workerCompany") ?? "Unknown"
        }
        else {
            mutableString = ""
        }
        
        firstNameField?.text = firstNameString
        lastNameField?.text = lastNameString
        emailField?.text = emailString
        phoneField?.text = phoneString
        mutableField?.text = mutableString
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
        dismissKeyboard()
    }
    
    func validation() -> Bool {
        if(firstNameField.text != "" && lastNameField.text != "" && emailField.text != "" && phoneField.text != "" && phoneField.text?.count == 10 && ((mutableField.text != "" && getTypeValue() != "Tenant") || getTypeValue() == "Tenant")) {
                return true
        }
        return false
    }
    
    private func checkEntries() {
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
        if (mutableField.text == "" && getTypeValue() != "Tenant") {
            if (getTypeValue() == "Landlord") {
                msgStr = "Please enter an address."
            }
            else {
                msgStr = "Please enter your company."
            }
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
}

extension ProfileEditViewController {
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
