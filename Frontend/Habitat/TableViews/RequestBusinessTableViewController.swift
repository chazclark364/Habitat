//
//  RequestBuisnessTableViewController.swift
//  Habitat
//
//  Created by Chaz Clark on 11/30/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation
import UIKit

class BusinessCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var pNumberLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
}

class RequestBusinessTableViewController: UITableViewController {
    var businesses: [YelpBusiness]?
    var organization: YelpBusiness?
    
    override func viewDidLoad() {
            HabitatAPI.YelpFusionAPI().loadRequest(completion: { request in
                if let Yelps = request {
                    self.businesses = Yelps
                    self.tableView.reloadData()
                    self.tableView.dataSource = self
                    //segue
                } else {
                    //Or set a label stating there are no request
                    self.present(AlertViews().errorAlert(msg: "There are no services in your area"), animated: true)
                }
            })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = businesses?.count {
            print(count)
            return count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "requestBusinessCell", for: indexPath) as! BusinessCell
        
        let Yelper = businesses?[indexPath.row]
        cell.nameLabel?.text = Yelper?.name
        cell.addressLabel?.text = Yelper?.address
        cell.distanceLabel?.text = Yelper?.distance?.description
        cell.pNumberLabel?.text = Yelper?.phoneNumber
        cell.ratingLabel?.text = Yelper?.rating?.description
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0;
    }
    
}
