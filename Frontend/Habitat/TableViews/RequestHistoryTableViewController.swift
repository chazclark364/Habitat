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
    var request: [MaintenanceRequest]?
    //Initialize WebSocket
    //Change protocal as needed
    var socket = WebSocket(url: URL(string: "ws://localhost:1337/")!, protocols: ["chat"])
    var message = ""
    
    override func viewDidLoad() {
        socket.delegate = self
        socket.connect()
        if let userId = UserDefaults.standard.object(forKey: "userID") {
            HabitatAPI.RequestAPI().getRequestForId(userId: userId as! Int, completion: { request in
                if let requestHistory = request {
                    self.request = requestHistory
                    self.tableView.reloadData()
                    //segue
                } else {
                    //alert user wrong credentials
                    //                self.present(AlertViews().didNotLogin(), animated: true)
                    
                }
            })
        }
    }
    
    deinit {
        socket.disconnect(forceTimeout: 0)
        socket.delegate = nil
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "requestHistoryCell", for: indexPath) as! RequestHistoryCell
        
            let maintenace = request?[indexPath.row]
            cell.titleLabel?.text = maintenace?.title
            cell.descriptionLabel?.text = maintenace?.requestDescription
     
        return cell
    }
    
    func update(request: MaintenanceRequest) {
        
    }
    
    func messageReceived(_ message: String, senderName: String) {
        
    }

}
// MARK: - WebSocketDelegate
extension RequestHistoryTableViewController : WebSocketDelegate {
    func websocketDidConnect(socket: WebSocketClient) {
        socket.write(string: UserDefaults.standard.string(forKey: "userId") ?? "Error")
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
        socket.write(string: message)
    }
    
}
