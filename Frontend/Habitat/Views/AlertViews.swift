//
//  AlertViews.swift
//  Habitat
//
//  Created by Chaz Clark on 10/6/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation
import UIKit

//This class will handle presenting any alerts the user needs to know
class AlertViews: UIAlertController {
    
    func didNotCreateUserAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Something went wrong", message: "Could not sign up user.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        return alert
    }
    
    func didNotLogin() -> UIAlertController {
        let alert = UIAlertController(title: "Something went wrong", message: "Please check credentials.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        return alert
    }
    
    func passwordNoMatch() -> UIAlertController {
        let alert = UIAlertController(title: "Something went wrong", message: "Passwords do not match.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        return alert
    }
    
    func enterFirstName() -> UIAlertController {
        let alert = UIAlertController(title: "Something went wrong", message: "Please enter a first name.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        return alert
    }
    
    func enterLastName() -> UIAlertController {
        let alert = UIAlertController(title: "Something went wrong", message: "Please enter a last name.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        return alert
    }
    
    func enterEmail() -> UIAlertController {
        let alert = UIAlertController(title: "Something went wrong", message: "Please enter an email address.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        return alert
    }
    
    func enterPhoneNumber() -> UIAlertController {
        let alert = UIAlertController(title: "Something went wrong", message: "Please enter a phone number.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        return alert
    }
    
    func phoneNumberLength() -> UIAlertController {
        let alert = UIAlertController(title: "Something went wrong", message: "Please include an area code on your phone number.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        return alert
    }
    
    func invalidEmail() -> UIAlertController {
        let alert = UIAlertController(title: "Something went wrong", message: "Please enter a valid email address.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        return alert
    }
    
    func enterPassword() -> UIAlertController {
        let alert = UIAlertController(title: "Something went wrong", message: "Please enter a password.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        return alert
    }
    
    func reenterPassword() -> UIAlertController {
        let alert = UIAlertController(title: "Something went wrong", message: "Please re-enter your password.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        return alert
    }
}
