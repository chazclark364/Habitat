//
//  PropertySelectViewController.swift
//  Habitat
//
//  Created by Travis Stanger on 12/2/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation
import UIKit

class PropertyCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
}
class PropertySelectViewController: UITableViewController {
    

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var propertyLabel: UILabel!
    
    var properties: [Property]?
    var selectedProperty: Property?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (UserDefaults.standard.bool(forKey: "darkMode")) {
            view.backgroundColor = #colorLiteral(red: 0.1568627451, green: 0.1568627451, blue: 0.2352941176, alpha: 1)
            backButton.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.3529411765, alpha: 1)
            newButton.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.3529411765, alpha: 1)
        }
        else {
            view.backgroundColor = #colorLiteral(red: 1, green: 0.7294117647, blue: 0.3607843137, alpha: 1)
            backButton.backgroundColor = #colorLiteral(red: 1, green: 0.7916666667, blue: 0.5, alpha: 1)
            newButton.backgroundColor = #colorLiteral(red: 1, green: 0.7916666667, blue: 0.5, alpha: 1)
        }
        tableView.dataSource = self
        var propId = 0
        if (UserDefaults.standard.string(forKey: "userType") == "Tenant") {
            propId = UserDefaults.standard.integer(forKey: "tenantLandlordId")
            propertyLabel.text = "Tap a listing to select as your residence."
            HabitatAPI.UserAPI().vacantPropertiesTable(completion: { allProperties in
                if let availableProperties = allProperties {
                    self.properties = availableProperties
                    self.tableView.reloadData()
                    self.tableView.dataSource = self
                } else {
                    self.present(AlertViews().errorAlert(msg: "There are no available properties."), animated: true)
                }
            })
        }
        else {
            propId = UserDefaults.standard.integer(forKey: "userID")
            propertyLabel.text = "Tap a listing to edit."
            HabitatAPI.UserAPI().landlordPropertiesTable(propId: propId, completion: {  allProperties in
                if let availableProperties = allProperties {
                    self.properties = availableProperties
                    self.tableView.reloadData()
                    self.tableView.dataSource = self
                } else {
                    self.present(AlertViews().errorAlert(msg: "There are no available properties."), animated: true)
                }
            })
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = properties?.count {
            return count - 1
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "propertyCell", for: indexPath) as! PropertyCell
        
        let property = properties?[indexPath.row] //2.
        
        let propertyId = property?.propertyId
        
        cell.titleLabel?.text = property?.address ?? "No Address"
        cell.detailLabel?.text = property?.livingStatus ?? ""
        
        return cell //4.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selected = properties?[indexPath.row]
        let propertyId = selected?.propertyId
        
        if (UserDefaults.standard.string(forKey: "userType") == "Tenant") {
            // get old property information
            var possibleProperty: Property?
            var currPropertyId = UserDefaults.standard.integer(forKey: "propertyId")
            HabitatAPI.UserAPI().getProperty(propertyId: currPropertyId, completion: {  property in
                possibleProperty = property
                //Means the creation was succesful
                if let newProperty = possibleProperty {
                    // update old property to vacant
                    newProperty.livingStatus = "Vacant"
                    HabitatAPI.UserAPI().updateProperty(property: newProperty, propId: currPropertyId, completion: { property in
                        UserDefaults.standard.set("", forKey: "propertyId")
                        UserDefaults.standard.synchronize()
                    })
                } else {
                    //Alert with error message if anything goes wrong
                    self.present(AlertViews().errorAlert(msg: "There was an issue completing your request."),   animated: true)
                }
            })
        
            // update new property to occupied
            selected?.livingStatus = "Occupied"
            HabitatAPI.UserAPI().updateProperty(property: selected, propId: propertyId ?? 0, completion: { property in
                
            })

            // update userdefaults and synchronize
            UserDefaults.standard.set(propertyId, forKey: "propertyId")
            UserDefaults.standard.synchronize()
            self.performSegue(withIdentifier: "selectPropertyToEditProfile", sender: nil)
        } else {
            UserDefaults.standard.set(selected?.propertyId, forKey: "selectedPropertyId")
            UserDefaults.standard.set(selected?.address, forKey: "selectedPropertyAddress")
            UserDefaults.standard.set(selected?.rentDueDate, forKey: "selectedPropertyDueDate")
            UserDefaults.standard.set(selected?.livingStatus, forKey: "selectedPropertyStatus")
            UserDefaults.standard.set(selected?.workerId, forKey: "selectedPropertyWorkerId")
            UserDefaults.standard.set(selected?.landlordId, forKey: "selectedPropertyLandlordId")
            self.performSegue(withIdentifier: "selectPropertyToUpdateProperty", sender: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
