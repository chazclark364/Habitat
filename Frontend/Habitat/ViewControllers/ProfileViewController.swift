//
//  ProfileViewController.swift
//  Habitat
//
//  Created by Chaz Clark on 9/24/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var backgroundTop: UIView!
    @IBOutlet weak var backgroundBottom: UIView!
    @IBOutlet weak var nameFirstLast: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var type: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        backgroundBottom.layer.cornerRadius = 24
        backgroundBottom.clipsToBounds = true
        backgroundTop.layer.cornerRadius = 24
        backgroundTop.clipsToBounds = true
        profileImage.layer.cornerRadius = 24
        profileImage.clipsToBounds = true
        getUserInfo()
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        clearData()
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
                self.present(AlertViews().errorAlert(msg: "Could not sign up user."), animated: true)
            }
        })
    }
    
    func clearData() {
        let savedData = UserDefaults.standard
        savedData.set("", forKey: "userFirstName")
        savedData.set("", forKey: "userLastName")
        savedData.set("", forKey: "userEmail")
        savedData.set("", forKey: "userPhoneNumber")
        savedData.set("", forKey: "userType")
        savedData.set("", forKey: "userID")
        UserDefaults.standard.synchronize()
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
        UserDefaults.standard.synchronize()
    }
    
    func updateDisplay() {
        var nameString = "Loading..."
        var emailString = "Loading..."
        var phoneNumberString = "Loading..."
        var userTypeString = "Loading..."
        nameString = UserDefaults.standard.string(forKey: "userFirstName") ?? "Unknown"
        nameString += " "
        nameString += UserDefaults.standard.string(forKey: "userLastName") ?? " "
        emailString = UserDefaults.standard.string(forKey: "userEmail") ?? "Unknown"
        phoneNumberString = UserDefaults.standard.string(forKey: "userPhoneNumber") ?? "Unknown"
        userTypeString = UserDefaults.standard.string(forKey: "userType") ?? "Unknown"
        userTypeString = userTypeString.prefix(1).uppercased() + userTypeString.dropFirst()
        let start = phoneNumberString.index(phoneNumberString.startIndex, offsetBy: 3)
        let end = phoneNumberString.index(phoneNumberString.endIndex, offsetBy: -4)
        let range = start..<end
        var phoneString = "(" + phoneNumberString.prefix(3) + ") "
        phoneString += phoneNumberString[range]
        phoneString += "-" + phoneNumberString.suffix(4)
        nameFirstLast?.text = nameString
        email?.text = emailString
        phone?.text = phoneString
        type?.text = userTypeString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
