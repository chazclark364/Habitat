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
import Starscream

class RequestCreateViewController: UIViewController {
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var problemText: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    var delegate: NotificationDelegate?
    var serviceDelegate: RequestDelegate?
    var socket = WebSocket(url: URL(string: "ws://proj309-pp-01.misc.iastate.edu:8080/websocket//")!, protocols: nil)
    var message = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectSocket()
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
    
    func constructNotification() -> String {
        var notification = String()
        var type = UserDefaults.standard.string(forKey: "userType")
        if type == "Tenant" {
            if let landlordId = UserDefaults.standard.string(forKey: "tenantLandlordId") {
                notification += "\(landlordId)"
            } else {
                notification += "-1"
            }
            notification += ","
            //Service worker
            notification += "1"
            notification += ","
            //Title of Notification
            if message.isEmpty {
                notification += titleTextField.text ?? "New Request"
            } else {
                notification += message
            }
        } else if type == "Landlord" {
            if let landlordId = UserDefaults.standard.string(forKey: "userID") {
                notification += "\(landlordId)"
            } else {
                notification += "-1"
            }
            notification += ","
            //Service worker
            notification += "1"
            notification += ","
            //Title of Notification
            if message.isEmpty {
                notification += titleTextField.text ?? "New Request"
            } else {
                notification += message
            }
        }
        return notification
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
                    self.socket.write(string: self.constructNotification())
                   // Sending request?
                    self.serviceDelegate?.setServiceRequest(service: returnedRequest)
                    self.performSegue(withIdentifier: "createToHistory", sender: returnedRequest)
                } else {
                     self.present(AlertViews().errorAlert(msg: "Sorry, request could not be submitted"), animated: true)
                }
            })
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
}
extension RequestCreateViewController: SelectedRequestDelegate {
    func setSocket(socket: WebSocketClient?) {
        self.socket = socket as! WebSocket
    }
    
    func selectedRequest(service: MaintenanceRequest?) { }
}

// MARK: - WebSocketDelegate
extension RequestCreateViewController: WebSocketDelegate {
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
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) { }
    
}

// MARK: -Notification protocol
protocol NotificationDelegate {
    func sendNotification( message: String)
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
