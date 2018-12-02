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
    
   //Websocket Essentials
    var socket = WebSocket(url: URL(string: "ws://proj309-pp-01.misc.iastate.edu:8080/websocket/")!, protocols: nil)
    var message = ""
    
    
    override func viewDidLoad() {
       connectSocket()
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
        getRequests()
    }
    
//    deinit {
//        socket.disconnect(forceTimeout: 0)
//        socket.delegate = nil
//    }
    
    func getRequests() {
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
    }
    
    func connectSocket() {
        var urlStr = "ws://proj309-pp-01.misc.iastate.edu:8080/websocket/"
        let userId = UserDefaults.standard.integer(forKey: "userID")
        urlStr += userId.description ?? "0"
        socket = WebSocket(url: URL(string: urlStr)!, protocols: [])
        socket.delegate = self
        socket.connect()
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
    
    @IBAction func didPressCreate(_ sender: Any) {
        delagate?.setSocket(socket: socket)
    }
    
    //Order should always go landlord/worker/Message
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
                notification += "New Request"
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
                notification += "New Request"
            } else {
                notification += message
            }
        } else {
            
        }
       return notification
    }
    
    func messageReceived(_ message: String) {
        //Display Notification
        self.present(AlertViews().notificationAlert(msg: message), animated: true)
        getRequests()
    }
    
   
}
// MARK: - WebSocketDelegate
extension RequestHistoryTableViewController: WebSocketDelegate {
    //TODO add message protocal
    func websocketDidConnect(socket: WebSocketClient) {
        
        print("Websoccket connected")
        //TEST
    //    socket.write(string: "81,1,Test")
        //Place in
//        self.message = ""
//        socket.write(string: constructNotification())
//        print(constructNotification())
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        /*
         The Websocket will disconeect if the other user is not currently availible
         If the webscket disconnects when trying to send a notification reconnect. Place the
         notification in a queue until it succesfully sent
         */
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

// MARK: - notificationDelegate
extension RequestHistoryTableViewController: NotificationDelegate {
    func sendNotification( message: String) {
        connectSocket()
        self.message = message
        socket.write(string: constructNotification())
    }
    
    
}

protocol SelectedRequestDelegate {
    func selectedRequest(service: MaintenanceRequest?)
    func setSocket(socket: WebSocketClient?)
}
//User 1, user 2, title of request (with no request)

