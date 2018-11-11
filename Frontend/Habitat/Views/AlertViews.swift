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
    
    func errorAlert(msg: String) -> UIAlertController {
        let alert = UIAlertController(title: "There was an error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }
    
    func updateAlert(msg: String, identifier: String) -> UIAlertController {
        let alert = UIAlertController(title: "Updated information", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }
    
    func notificationAlert(msg: String) -> UIAlertController {
        let alert = UIAlertController(title: msg, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }
}
