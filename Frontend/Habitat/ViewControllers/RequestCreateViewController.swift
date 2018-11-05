//
//  RequestCreateViewController.swift
//  Habitat
//
//  Created by Travis Stanger on 10/15/18.
//  Copyright © 2018 PP1. All rights reserved.
//
//  This view controller will allow users (tenants and landlords only?)
//    to create maintenance requests. Will ask for a title, description,
//    photo for AR?, will include a back button to return to main page,
//    submit button to submit the maintenance request (tenants will
//    require landlord approval, landlord submission automatically
//    approved).
//

import Foundation
import UIKit

class RequestCreateViewController: UIViewController {
    //TODO: Construct a user object
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        submitButton.isEnabled = validation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        updateDisplay()
    }

    private func validation() -> Bool {
        if(titleTextField.text != "" && descriptionTextView.text != "") {
            if(UserDefaults.standard.object(forKey: "userType") as! String == "tenant") {
                if(UserDefaults.standard.object(forKey: "landlord") != nil) {
                     return true
                } else {
                    //TODO: Set "Need a landlord" message
                }
            }
           
        }
        return false
    }
    
    func updateDisplay() {
        submitButton.isEnabled = validation()
        dismissKeyboard()
    }
    
    @IBAction func didPressSubmit(_ sender: Any) {
        var newRequest = MaintenanceRequest()
        var returnedRequest: MaintenanceRequest?
        
        newRequest.requestDescription = descriptionTextView.text
        newRequest.title = titleTextField.text
        newRequest.status = "Submitted"
        newRequest.requestee = UserDefaults.standard.object(forKey: "userID") as! Int
        newRequest.landlord = UserDefaults.standard.object(forKey: "landlord") as! Int
        
            HabitatAPI.RequestAPI().createRequest(request: newRequest,  completion: {  request in
                if let returnedRequest = request {
                    //TODO: Add delegation to request
                    self.performSegue(withIdentifier: "createToHistory", sender: nil)
                    //segue
                } else {
                    //alert user wrong credentials
                }
            })
        
    }
    
}


extension RequestCreateViewController {
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
