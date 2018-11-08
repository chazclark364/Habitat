//
//  LandlordSelectViewController.swift
//  Habitat
//
//  Created by Travis Stanger on 11/4/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation
import UIKit

class LandlordSelectViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var landlords: [Landlord]?
    var selectedLandlord: Landlord?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        HabitatAPI.UserAPI().getLandlords(completion: {  allLandlords in
            if let availibleLandlords = allLandlords {
              self.landlords = availibleLandlords
               self.tableView.reloadData()
                self.tableView.dataSource = self
            } else {
                self.present(AlertViews().errorAlert(msg: "There are no avilible landlords."), animated: true)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC : ProfileEditViewController = segue.destination as! ProfileEditViewController
        destVC.selectedLandlord = sender as! Landlord
//        if let selected = selectedLandlord {
//            self.performSegue(withIdentifier: "landLordSelectionToEdit", sender: selected)
//        }
    }
      
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = landlords?.count {
            return count - 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! //1.
        
        let landLord = landlords?[indexPath.row] //2.
        
        cell.textLabel?.text = landLord?.landlordId?.description //TODO: Change API to send name
        
        return cell //4.
    }
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let selected = landlords?[indexPath.row]
        
        //TODO: Segue
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

