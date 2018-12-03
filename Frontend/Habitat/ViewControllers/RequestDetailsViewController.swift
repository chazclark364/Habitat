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
import Starscream


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
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    var nextStatus = String()
    var updatedRequest: MaintenanceRequest?
    var delegate: SelectedRequestDelegate?
    var modifiedDescription = ""
    
    //Websocket Essentials
    var socket = WebSocket(url: URL(string: "ws://proj309-pp-01.misc.iastate.edu:8080/websocket/")!, protocols: nil)
    var message = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (UserDefaults.standard.bool(forKey: "darkMode")) {
            view.backgroundColor = #colorLiteral(red: 0.1568627451, green: 0.1568627451, blue: 0.2352941176, alpha: 1)
            backButton.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.3529411765, alpha: 1)
            updateButton.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.3529411765, alpha: 1)
            statusView.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.3529411765, alpha: 1)
        }
        else {
            view.backgroundColor = #colorLiteral(red: 1, green: 0.7294117647, blue: 0.3607843137, alpha: 1)
            backButton.backgroundColor = #colorLiteral(red: 1, green: 0.7916666667, blue: 0.5, alpha: 1)
            updateButton.backgroundColor = #colorLiteral(red: 1, green: 0.7916666667, blue: 0.5, alpha: 1)
            statusView.backgroundColor = #colorLiteral(red: 1, green: 0.7916666667, blue: 0.5, alpha: 1)
        }
        if (UserDefaults.standard.string(forKey: "userType") == "Landlord") {
            updateButton.isHidden = false
            descriptionTextView.isEditable = true
        }
        else {
            updateButton.isHidden = true
            descriptionTextView.isEditable = false
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
        descriptionTextView.text = servicerRequest.requestDescription
        modifiedDescription = descriptionTextView.text
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        connectSocket()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func messageReceived(_ message: String) {
        //Display Notification
        self.present(AlertViews().notificationAlert(msg: message), animated: true)
    }
    
    func connectSocket() {
        var urlStr = "ws://proj309-pp-01.misc.iastate.edu:8080/websocket/"
        var userId = UserDefaults.standard.integer(forKey: "userID")
        urlStr += userId.description ?? "0"
        socket = WebSocket(url: URL(string: urlStr)!, protocols: [])
        socket.delegate = self
        socket.connect()
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        dismissKeyboard()
    }
    
    func setProgressBar() {
        let status = servicerRequest.status
        if status == "Approved" {
            stageApproved.backgroundColor = UIColor.green
        } else if status == "In Progress" {
            stageApproved.backgroundColor = UIColor.green
            stageInProgress.backgroundColor = UIColor.green
        } else if status == "Completed" {
            stageApproved.backgroundColor = UIColor.green
            stageInProgress.backgroundColor = UIColor.green
            stageCompleted.backgroundColor = UIColor.green
        }
    }
    
    func validation() -> Bool {
        if(UserDefaults.standard.object(forKey: "userType") as? String == "Tenant") {
            return false
        }
        if(UserDefaults.standard.object(forKey: "userType") as? String == "Landlord") {
            //Landlord should have permision to approve and complete and in progress
            if(servicerRequest.status == "Submitted") {
                servicerRequest.status = "Approved"
            } else if(servicerRequest.status == "Approved") {
                servicerRequest.status = "In Progress"
            } else {
                servicerRequest.status = "Completed"
            }
            return true
        }
        if(UserDefaults.standard.object(forKey: "userType") as? String == "Worker") &&  servicerRequest.status == "Approved"{
            servicerRequest.status = "In Progress"
            return true
        }
        
        return false
    }
    
    func constructNotification() -> String {
        var notification = String()
        message = servicerRequest.title ?? "Request"
        var type = UserDefaults.standard.string(forKey: "userType")
        if type == "Tenant" {
            let landlordId = UserDefaults.standard.string(forKey: "tenantLandlordId")
            notification += "\(landlordId)"
            notification += ","
            //Service worker
            notification += "1"
            notification += ","
            //Title of Notification
            notification += message
        } else if type == "Landlord" {
            let tenantId = servicerRequest.requestee ?? 0
            notification += "\(tenantId)"
            notification += ","
            //Service worker
            notification += "1"
            notification += ","
            //Title of Notification
            notification += message
        } else {
            
        }
        print(notification)
        return notification
    }
    
    @IBAction func didPressBack(_ sender: Any) {
        //Update Service Request if description was modified
        if(modifiedDescription != descriptionTextView.text) {
            servicerRequest.requestDescription = descriptionTextView.text
            let id = UserDefaults.standard.object(forKey: "userID") as? Int
            HabitatAPI.RequestAPI().updateRequest(userId: id ?? 0, request: servicerRequest, completion: { serviceRequest in
                if let requestUpdated = serviceRequest {
                    self.updatedRequest = requestUpdated
                    self.socket.write(string: self.constructNotification())
                    self.performSegue(withIdentifier: "updateToHistory", sender: nil)                    //segue
                } else {
                    //Or set a label stating there are no request
                    self.present(AlertViews().errorAlert(msg: "Failed to update description"), animated: true)
                    self.performSegue(withIdentifier: "updateToHistory", sender: nil)      
                }
            })
        } else {
            self.performSegue(withIdentifier: "updateToHistory", sender: nil)
        }
    }
    
    @IBAction func didPressUpdate(_ sender: Any) {
        if(validation()) {
            
            let id = UserDefaults.standard.object(forKey: "userID") as? Int
            HabitatAPI.RequestAPI().updateRequest(userId: id ?? 0, request: servicerRequest, completion: { serviceRequest in
                if let requestUpdated = serviceRequest {
                    self.updatedRequest = requestUpdated
                    self.setServiceRequest(service: requestUpdated)
                    self.socket.write(string: self.constructNotification())
                    self.performSegue(withIdentifier: "updateToHistory", sender: nil)
                    //segue
                } else {
                    //Or set a label stating there are no request
                    self.present(AlertViews().errorAlert(msg: "You're not allowed to update"), animated: true)
                }
            })
            
        }
    }
    
    func messageReceived(_ message: String, senderName: String) {
        //Display Notification
        self.present(AlertViews().notificationAlert(msg: message), animated: true)
    }
}

extension RequestDetailsViewController: RequestDelegate {
    func setServiceRequest(service: MaintenanceRequest) {
        self.servicerRequest = service
    }
}
extension RequestDetailsViewController: SelectedRequestDelegate {
    func setSocket(socket: WebSocketClient?) {
    }
    
    func selectedRequest(service: MaintenanceRequest?) {
        self.servicerRequest = service ?? MaintenanceRequest()
    }
}


// MARK: - WebSocketDelegate
extension RequestDetailsViewController : WebSocketDelegate {
    func websocketDidConnect(socket: WebSocketClient) {
        print("Websoccket connected in creating")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("The websocket disconnected")
        socket.connect()
        print(error)
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        messageReceived(text)
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        
    }
}
extension RequestDetailsViewController {
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
