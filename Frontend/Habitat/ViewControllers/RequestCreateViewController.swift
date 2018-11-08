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
    @IBOutlet weak var problemText: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    var delegate: NotificationDelegate?
    var serviceDelegate: RequestDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        if (UserDefaults.standard.bool(forKey: "darkMode")) {
            view.backgroundColor = #colorLiteral(red: 0.1568627451, green: 0.1568627451, blue: 0.2352941176, alpha: 1)
            submitButton.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.3529411765, alpha: 1)
            cancelButton.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.3529411765, alpha: 1)
            problemText.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            descriptionText.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        else {
            view.backgroundColor = #colorLiteral(red: 1, green: 0.7294117647, blue: 0.3607843137, alpha: 1)
            submitButton.backgroundColor = #colorLiteral(red: 1, green: 0.7916666667, blue: 0.5, alpha: 1)
            cancelButton.backgroundColor = #colorLiteral(red: 1, green: 0.7916666667, blue: 0.5, alpha: 1)
            problemText.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            descriptionText.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        submitButton.isEnabled = validation()
        
        //TODO: Get TenatnID
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
            if(UserDefaults.standard.object(forKey: "userType") as! String == "Tenant") {
                if(UserDefaults.standard.object(forKey: "tenantLandlordId") != nil) {
                     return true
                } else {
                    self.present(AlertViews().errorAlert(msg: "Please select your landlord first"), animated: true)
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
        newRequest.requestee = UserDefaults.standard.object(forKey: "userID") as? Int
        newRequest.landlord = UserDefaults.standard.object(forKey: "tenantLandlordId") as? Int
        
            HabitatAPI.RequestAPI().createRequest(request: newRequest,  completion: {  request in
                if let returnedRequest = request {
                    //TODO: Check function
                    self.delegate?.sendNotification(message: "There is a new Request")
                    RequestHistoryTableViewController().sendNotification(message: "There is a new Request")
                    //Sending request?
                    self.serviceDelegate?.setServiceRequest(service: returnedRequest)
                    self.performSegue(withIdentifier: "createToHistory", sender: returnedRequest)
                } else {
                     self.present(AlertViews().errorAlert(msg: "Sorry, request could not be submitted"), animated: true)
                }
            })
    }
    func getTenant() {
        
    }
}
// MARK: -Notification protocol
protocol NotificationDelegate {
    func sendNotification(message: String)
}

// MARK: -Request protocol
protocol RequestDelegate {
    func setServiceRequest(service: MaintenanceRequest)
}

extension RequestCreateViewController {
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
