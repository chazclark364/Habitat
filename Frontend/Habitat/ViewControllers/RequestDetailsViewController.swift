//
//  RequestDetailsViewController.swift
//  Habitat
//
//  Created by Travis Stanger on 10/15/18.
//  Copyright © 2018 PP1. All rights reserved.
//
//  This view controller will show a single request, the details for that request,
//    the progress bar (submitted/approved/in progress/complete), cancel request
//    (for tenant), update status (for landlord/worker), add a comment? (for any
//    user type), back button to return to main maintenance page with history
//

import Foundation
import UIKit


class RequestDetailsViewController: UIViewController {
    //TODO: Construct a user object
    @IBOutlet weak var stageSubmitted: UIView!
    @IBOutlet weak var stageInProgress: UIView!
    @IBOutlet weak var stageApproved: UIView!
    @IBOutlet weak var stageCompleted: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var requestTitle: UILabel!
    var servicerRequest = MaintenanceRequest()
    @IBOutlet weak var descriptionTextView: UITextView!
    var nextStatus = String()
    var updatedRequest: MaintenanceRequest?
    var delegate: SelectedRequestDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (UserDefaults.standard.bool(forKey: "darkMode")) {
            view.backgroundColor = #colorLiteral(red: 0.1568627451, green: 0.1568627451, blue: 0.2352941176, alpha: 1)
        }
        else {
            view.backgroundColor = #colorLiteral(red: 1, green: 0.7294117647, blue: 0.3607843137, alpha: 1)
        }
        statusView.layer.cornerRadius = 5
        statusView.clipsToBounds = true
        stageSubmitted.layer.cornerRadius = 25
        stageSubmitted.clipsToBounds = true
        stageInProgress.layer.cornerRadius = 25
        stageInProgress.clipsToBounds = true
        stageApproved.layer.cornerRadius = 25
        stageApproved.clipsToBounds = true
        stageCompleted.layer.cornerRadius = 25
        stageCompleted.clipsToBounds = true
        setProgressBar()
        requestTitle.text = servicerRequest.title ?? "Request"
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setProgressBar() {
        let status = servicerRequest.status
        if status == "Approved" {
            stageApproved.backgroundColor = UIColor.blue
        } else if status == "In Progress" {
            stageApproved.backgroundColor = UIColor.blue
            stageInProgress.backgroundColor = UIColor.blue
        } else if status == "Completed" {
            stageApproved.backgroundColor = UIColor.blue
            stageInProgress.backgroundColor = UIColor.blue
            stageCompleted.backgroundColor = UIColor.blue
        }
    }
    
    func validation() -> Bool {
        if(UserDefaults.standard.object(forKey: "userType") as? String == "Tenant") {
            return false
        }
        if(UserDefaults.standard.object(forKey: "userType") as? String == "Landlord") &&  servicerRequest.status == "Submitted"{
            servicerRequest.status = "Approved"
            return true
        }
        if(UserDefaults.standard.object(forKey: "userType") as? String == "Worker") &&  servicerRequest.status == "In Progress"{
             servicerRequest.status = "Completed"
            return true
        }

        return false
    }
    
    @IBAction func didPressUpdate(_ sender: Any) {
        if(validation()) {
            
            let id = UserDefaults.standard.object(forKey: "userId") as? Int
            HabitatAPI.RequestAPI().updateRequest(userId: id ?? 0, request: servicerRequest, completion: { serviceRequest in
            if let requestUpdated = serviceRequest {
                self.updatedRequest = requestUpdated
                self.setServiceRequest(service: requestUpdated)
                self.performSegue(withIdentifier: "updateToHistory", sender: nil)
                //segue
            } else {
                //Or set a label stating there are no request
                self.present(AlertViews().errorAlert(msg: "You're not allowed to update"), animated: true)
            }
        })
            
        }
    }
}

extension RequestDetailsViewController: RequestDelegate {
    func setServiceRequest(service: MaintenanceRequest) {
        self.servicerRequest = service
    }
}
extension RequestDetailsViewController: SelectedRequestDelegate {
    func selectedRequest(service: MaintenanceRequest?) {
        self.servicerRequest = service ?? MaintenanceRequest()
    }
}
