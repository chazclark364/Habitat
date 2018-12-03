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
    
    @IBOutlet weak var backgroundTop: UIView!
    @IBOutlet weak var backgroundBottom: UIView!
    @IBOutlet weak var nameFirstLast: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressValue: UILabel!
    @IBOutlet weak var rentValue: UILabel!
    @IBOutlet weak var rentLabel: UILabel!
    @IBOutlet weak var landlordLabel: UILabel!
    @IBOutlet weak var landlordValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (UserDefaults.standard.bool(forKey: "darkMode")) {
            view.backgroundColor = #colorLiteral(red: 0.1568627451, green: 0.1568627451, blue: 0.2352941176, alpha: 1)
        }
        else {
            view.backgroundColor = #colorLiteral(red: 1, green: 0.7294117647, blue: 0.3607843137, alpha: 1)
        }
        // Do any additional setup after loading the view, typically from a nib.
        backgroundBottom.layer.cornerRadius = 24
        backgroundBottom.clipsToBounds = true
        backgroundTop.layer.cornerRadius = 24
        backgroundTop.clipsToBounds = true
        getUserInfo()
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.set(false, forKey: "darkMode")
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
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
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
        if (UserDefaults.standard.string(forKey: "userType") == "Worker") {
            addressLabel.text = "Company"
            addressValue.text = UserDefaults.standard.string(forKey: "workerCompany")
            rentLabel.isHidden = true
            rentValue.isHidden = true
            landlordLabel.isHidden = true
            landlordValue.isHidden = true
        } else {
            addressLabel.text = "Address"
            if (UserDefaults.standard.string(forKey: "userType") == "Tenant") {
                rentLabel.isHidden = false
                rentValue.isHidden = false
                var rentString = UserDefaults.standard.string(forKey: "tenantMonthlyRent") ?? "???"
                rentString += " ("
                rentString += UserDefaults.standard.string(forKey: "tenantDueDate") ?? "N/A"
                rentString += ")"
                rentValue.text = rentString
                landlordLabel.isHidden = false
                landlordValue.isHidden = false
                addressValue.text = UserDefaults.standard.string(forKey: "tenantResidence")
                landlordValue.text = UserDefaults.standard.string(forKey: "landlordName")
            }
            else {
                addressValue.text = UserDefaults.standard.string(forKey: "landlordAddress")
                rentLabel.isHidden = true
                rentValue.isHidden = true
                landlordLabel.isHidden = true
                landlordValue.isHidden = true
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
