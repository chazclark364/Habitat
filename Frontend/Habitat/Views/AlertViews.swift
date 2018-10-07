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
        let alert = UIAlertController(title: "Something went wrong", message: "Could not sign up user", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        return alert
    }
    
    func didNotLogin() -> UIAlertController {
        let alert = UIAlertController(title: "Something went wrong", message: "Please check credentials", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        return alert
    }
    
}
