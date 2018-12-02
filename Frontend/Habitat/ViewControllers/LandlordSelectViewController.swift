//
//  LandlordSelectViewController.swift
//  Habitat
//
//  Created by Travis Stanger on 11/4/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation
import UIKit

class LandlordSelectViewController: UITableViewController {
    
  //  @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!

    var landlords: [Landlord]?
    var selectedLandlord: Landlord?
    override func viewDidLoad() {
        super.viewDidLoad()
        if (UserDefaults.standard.bool(forKey: "darkMode")) {
            view.backgroundColor = #colorLiteral(red: 0.1568627451, green: 0.1568627451, blue: 0.2352941176, alpha: 1)
            topView.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.3529411765, alpha: 1)
        }
        else {
            view.backgroundColor = #colorLiteral(red: 1, green: 0.7294117647, blue: 0.3607843137, alpha: 1)
            topView.backgroundColor = #colorLiteral(red: 1, green: 0.7916666667, blue: 0.5, alpha: 1)
        }
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
      
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = landlords?.count {
            return count - 1
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell() //1.
        
        let landLord = landlords?[indexPath.row] //2.
        
        var possibleUser: User?
        let userId = landLord?.landlordId
        cell.textLabel?.text = userId?.description
        HabitatAPI.UserAPI().getUserInfo(userId: userId ?? 0, completion: {  user in
            possibleUser = user
            //Means the creation was succesful
            if let newUser = possibleUser {
                //Save locally
                var landlordString = "Loading..."
                landlordString = newUser.firstName ?? ""
                landlordString += " "
                landlordString += newUser.lastName ?? ""
                landlordString += " ("
                if (landLord?.address != nil) {
                    landlordString += landLord?.address ?? ""
                }
                else {
                    landlordString += "No Address"
                }
                landlordString += ")"
                cell.textLabel?.text = landlordString
            } else {
                //Alert with error message if anything goes wrong
                cell.textLabel?.text = "Error" //TODO: Change API to send name
                self.present(AlertViews().errorAlert(msg: "Could not sign up user."), animated: true)
            }
        })
        
        return cell //4.
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = landlords?[indexPath.row]
        let landlordId = selected?.landlordId
        
        let tenant = Tenant()
        var possibleTenant: Tenant?
        tenant.tenantId = UserDefaults.standard.integer(forKey: "userID")
        tenant.landlordId = selected?.landlordId
        tenant.monthlyRent = 309
        tenant.residence = "123"
        
        HabitatAPI.UserAPI().updateTenant(tenant: tenant, completion: { tenant in
            possibleTenant = tenant
            if let updateTenant = possibleTenant {
                UserDefaults.standard.set(updateTenant.landlordId, forKey: "tenantLandlordId")
                UserDefaults.standard.synchronize()
                var possibleUser: User?
                HabitatAPI.UserAPI().getUserInfo(userId: UserDefaults.standard.integer(forKey: "tenantLandlordId"), completion: {  user in
                    possibleUser = user
                    //Means the creation was succesful
                    if let newUser = possibleUser {
                        //Save locally
                        var landlordString = ""
                        landlordString = newUser.firstName ?? ""
                        landlordString += " "
                        landlordString += newUser.lastName ?? ""
                        UserDefaults.standard.set(landlordString, forKey: "landlordName")
                        self.performSegue(withIdentifier: "selectToEditProfile", sender: nil)
                    } else {
                        //Alert with error message if anything goes wrong
                        self.present(AlertViews().errorAlert(msg: "Could not select landlord."), animated: true)
                    }
                })
            }
            else {
                self.present(AlertViews().errorAlert(msg: "Could not update information."), animated: true)
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

