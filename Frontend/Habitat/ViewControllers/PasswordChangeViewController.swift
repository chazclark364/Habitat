//
//  PasswordChangeViewController.swift
//  Habitat
//
//  Created by Travis Stanger on 11/4/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation
import UIKit

class PasswordChangeViewController: UIViewController {
    
    @IBOutlet weak var currentPassField: UITextField!
    @IBOutlet weak var newPassField: UITextField!
    @IBOutlet weak var reenterPassField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (UserDefaults.standard.bool(forKey: "darkMode")) {
            view.backgroundColor = #colorLiteral(red: 0.1568627451, green: 0.1568627451, blue: 0.2352941176, alpha: 1)
            updateButton.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.3529411765, alpha: 1)
            backButton.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.3529411765, alpha: 1)
        }
        else {
            view.backgroundColor = #colorLiteral(red: 1, green: 0.7294117647, blue: 0.3607843137, alpha: 1)
            updateButton.backgroundColor = #colorLiteral(red: 1, green: 0.7916666667, blue: 0.5, alpha: 1)
            backButton.backgroundColor = #colorLiteral(red: 1, green: 0.7916666667, blue: 0.5, alpha: 1)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        updateButton.isEnabled = validation()
    }
    
    @IBAction func pressedUpdatePassword(_ sender: Any) {
        updatePassword()
    }
    
    private func updatePassword() {
        let user = User()
        let firstName = UserDefaults.standard.string(forKey: "userFirstName")
        let lastName = UserDefaults.standard.string(forKey: "userLastName")
        let email = UserDefaults.standard.string(forKey: "userEmail")
        let phone = UserDefaults.standard.string(forKey: "userPhone")
        let type = UserDefaults.standard.string(forKey: "userType")
        let userId = UserDefaults.standard.integer(forKey: "userID")
        var possibleUser: User?
        user.firstName = firstName
        user.lastName = lastName
        user.phoneNumber = phone
        user.type = type
        user.email = email
        user.userId = userId
        user.password = newPassField.text
        
        HabitatAPI.UserAPI().updateUserInfo(user: user, completion: {  user in
            possibleUser = user
            if let updateUser = possibleUser {
                updateUser.password = self.newPassField.text
                self.saveData(user: updateUser)
                //self.present(AlertViews().updateAlert(msg: "User information updated successfully.", identifier: "changePasswordToProfile"), animated: true)
                self.performSegue(withIdentifier: "changePasswordToProfile", sender: nil)
            } else {
                self.present(AlertViews().errorAlert(msg: "Could not update information."), animated: true)
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
        UserDefaults.standard.synchronize()
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        updateDisplay()
    }
    
    func updateDisplay() {
        updateButton.isEnabled = validation()
        dismissKeyboard()
    }
    
    private func validation() -> Bool {
        var msgStr = ""
        if (currentPassField.text == "") {
            msgStr = "Please enter your current password."
        }
        if (newPassField.text == "") {
            msgStr = "Please enter a new password."
        }
        if (reenterPassField.text == "") {
            msgStr = "Please re-enter your new password."
        }
        if (currentPassField.text != UserDefaults.standard.string(forKey: "password")) {
            msgStr = "Current password is incorrect."
        }
        if (newPassField.text != reenterPassField.text) {
            msgStr = "New passwords must match."
        }
        if(currentPassField.text != "" && newPassField.text != "" && reenterPassField.text != "" && newPassField.text == reenterPassField.text && currentPassField.text == UserDefaults.standard.string(forKey: "password")) {
            updateButton.isEnabled = true
            return true
        }
        self.present(AlertViews().errorAlert(msg: msgStr), animated: true)
        updateButton.isEnabled = false
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PasswordChangeViewController {
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
