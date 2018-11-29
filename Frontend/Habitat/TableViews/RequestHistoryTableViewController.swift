//
//  RequestHistoryTableViewController.swift
//  Habitat
//
//  Created by Chaz Clark on 11/1/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation
import UIKit
import Starscream

class RequestHistoryCell: UITableViewCell {
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
 
}

class RequestHistoryTableViewController: UITableViewController {
    var requests: [MaintenanceRequest]?
    //Initialize WebSocket
    //Change protocal as needed
   
    var delagate: SelectedRequestDelegate?
    @IBOutlet weak var topView: UIView!
    @IBOutlet var tbView: UITableView!
    //ws://localhost:8080/websocket/userId
    weak var maintenaceRequest: MaintenanceRequest?
    
   
    var socket = WebSocket(url: URL(string: "ws://proj309-pp-01.misc.iastate.edu:8080/websocket/")!, protocols: nil)
    var message = ""
    
    
    override func viewDidLoad() {
        var userId = (UserDefaults.standard.string(forKey: "userID"))
        var urlStr = "ws://proj309-pp-01.misc.iastate.edu:8080/websocket/"
        urlStr += userId?.description ?? "0"
        socket = WebSocket(url: URL(string: urlStr)!, protocols: [])
        if (UserDefaults.standard.bool(forKey: "darkMode")) {
            view.backgroundColor = #colorLiteral(red: 0.1568627451, green: 0.1568627451, blue: 0.2352941176, alpha: 1)
            tbView.backgroundColor = #colorLiteral(red: 0.1568627451, green: 0.1568627451, blue: 0.2352941176, alpha: 1)
            topView.backgroundColor = #colorLiteral(red: 0.1568627451, green: 0.1568627451, blue: 0.2352941176, alpha: 1)
        }
        else {
            view.backgroundColor = #colorLiteral(red: 1, green: 0.7294117647, blue: 0.3607843137, alpha: 1)
            tbView.backgroundColor = #colorLiteral(red: 1, green: 0.7294117647, blue: 0.3607843137, alpha: 1)
            topView.backgroundColor = #colorLiteral(red: 1, green: 0.7294117647, blue: 0.3607843137, alpha: 1)
        }
        socket.delegate = self
        socket.connect()
        if let userId = UserDefaults.standard.object(forKey: "userID") as? Int{
            HabitatAPI.RequestAPI().getRequestForId(userId: userId, completion: { request in
                if let requestHistory = request {
                    self.requests = requestHistory
                    self.tableView.reloadData()
                    self.tableView.dataSource = self
                    //segue
                } else {
                    //Or set a label stating there are no request
                   //self.present(AlertViews().errorAlert(msg: "There was a problem"), animated: true)
                }
            })
        }
        sendNotification(message: "")
    }
    
    deinit {
        socket.disconnect(forceTimeout: 0)
        socket.delegate = nil
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = requests?.count {
            return count - 1
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "requestHistoryCell", for: indexPath) as! RequestHistoryCell
        
            let maintenace = requests?[indexPath.row]
            cell.titleLabel?.text = maintenace?.title
            cell.descriptionLabel?.text = maintenace?.requestDescription
     
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        maintenaceRequest = requests?[indexPath.row]
        delagate?.selectedRequest(service: maintenaceRequest)
        RequestDetailsViewController().servicerRequest = maintenaceRequest ?? MaintenanceRequest()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RequestDetailsViewController {
            
           if let indexPath = self.tableView.indexPathForSelectedRow {
            destination.delegate = self as? SelectedRequestDelegate
            destination.servicerRequest = requests?[indexPath.row] ?? MaintenanceRequest()
            }
            
        }
    }

    
    func constructNotification() -> String {
        var notification = String()
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
            let tenantId = UserDefaults.standard.string(forKey: "tenantLandlordId")
            notification += "\(tenantId)"
            notification += ","
            //Service worker
            notification += "1"
            notification += ","
            //Title of Notification
            notification += message
        } else {
            
        }
       return notification
    }
    
    func messageReceived(_ message: String, senderName: String) {
        //Display Notification
        self.present(AlertViews().notificationAlert(msg: message), animated: true)
    }

}
// MARK: - WebSocketDelegate
extension RequestHistoryTableViewController : WebSocketDelegate {
    func websocketDidConnect(socket: WebSocketClient) {
        print("Websoccket connected")
        self.message = ""
        socket.write(string: constructNotification())
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("The websocket disconnected")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        // Check to see if valid message
        guard let data = text.data(using: .utf16),
            let jsonData = try? JSONSerialization.jsonObject(with: data),
            let jsonDict = jsonData as? [String: Any],
            let messageType = jsonDict["type"] as? String else {
                return
        }
        
        //If message is valid parse through it and notify user
        if messageType == "message",
            let messageData = jsonDict["data"] as? [String: Any],
            let messageAuthor = messageData["author"] as? String,
            let messageText = messageData["text"] as? String {
            
            messageReceived(messageText, senderName: messageAuthor)
        }
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        
    }
}

// MARK: - notificationDelegate
extension RequestHistoryTableViewController: NotificationDelegate {
    func sendNotification(message: String) {
        self.message = message
        socket.write(string: constructNotification())
    }
}

protocol SelectedRequestDelegate {
    func selectedRequest(service: MaintenanceRequest?)
}
//User 1, user 2, title of request (with no request)
