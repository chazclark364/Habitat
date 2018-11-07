//
//  RequestHistoryTableViewController.swift
//  Habitat
//
//  Created by Chaz Clark on 11/1/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation
import UIKit

class RequestHistoryCell: UITableViewCell {
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
}
class RequestHistoryTableViewController: UITableViewController {
    var request: [MaintenanceRequest]?
    
    override func viewDidLoad() {
        let userId = UserDefaults.standard.object(forKey: "userID")
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

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "requestHistoryCell", for: indexPath) as! RequestHistoryCell
        
            let maintenace = request?[indexPath.row]
            cell.titleLabel?.text = maintenace?.title
            cell.descriptionLabel?.text = maintenace?.requestDescription
     
        return cell
    }
    
    func update(request: MaintenanceRequest) {
        
    }

}
