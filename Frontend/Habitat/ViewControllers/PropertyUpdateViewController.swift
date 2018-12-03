//
//  PropertyUpdateViewController.swift
//  Habitat
//
//  Created by Travis Stanger on 12/2/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation
import UIKit

class PropertyUpdateViewController: UIViewController {
    
    @IBOutlet var propertyUpdateView: UIView!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var rentDueTextField: UITextField!
    @IBOutlet weak var statusSegmentControl: UISegmentedControl!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (UserDefaults.standard.bool(forKey: "darkMode")) {
            view.backgroundColor = #colorLiteral(red: 0.1568627451, green: 0.1568627451, blue: 0.2352941176, alpha: 1)
            saveButton.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.3529411765, alpha: 1)
            cancelButton.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.3529411765, alpha: 1)
        }
        else {
            view.backgroundColor = #colorLiteral(red: 1, green: 0.7294117647, blue: 0.3607843137, alpha: 1)
            saveButton.backgroundColor = #colorLiteral(red: 1, green: 0.7916666667, blue: 0.5, alpha: 1)
            cancelButton.backgroundColor = #colorLiteral(red: 1, green: 0.7916666667, blue: 0.5, alpha: 1)
        }
        
        if (UserDefaults.standard.string(forKey: "selectedPropertyStatus") == "Occupied") {
            statusSegmentControl.selectedSegmentIndex = 1
        }
        if (UserDefaults.standard.string(forKey: "selectedPropertyAddress") != nil) {
            addressTextField.text = UserDefaults.standard.string(forKey: "selectedPropertyAddress")
        }
        if (UserDefaults.standard.string(forKey: "selectedPropertyDueDate") != nil) {
            rentDueTextField.text = UserDefaults.standard.string(forKey: "selectedPropertyDueDate")
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        propertyUpdateView.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        checkEntries()
        if (validation()) {
            updateProperty()
        }
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        updateDisplayValidated()
    }
    
    func updateDisplayValidated() {
        dismissKeyboard()
    }
    
    func validation() -> Bool {
        if(addressTextField.text != "" && rentDueTextField.text != "") {
            return true
        }
        return false
    }
    
    private func checkEntries() {
        var msgStr = ""
        if (addressTextField.text == "") {
            msgStr = "Please enter an address."
        }
        if (rentDueTextField.text == "") {
            msgStr = "Please enter a due date."
        }
        if (msgStr != "") {
            self.present(AlertViews().errorAlert(msg: msgStr), animated: true)
        }
    }
    
    private func updateProperty() {
        let property = Property()
        var possibleProperty: Property?
        property.propertyId = UserDefaults.standard.integer(forKey: "selectedPropertyId")
        property.workerId = 1
        property.address = addressTextField.text
        property.rentDueDate = rentDueTextField.text
        property.landlordId = UserDefaults.standard.integer(forKey: "selectedLandlordId")
        if (statusSegmentControl.selectedSegmentIndex == 0) {
            property.livingStatus = "Vacant"
        }
        else {
            property.livingStatus = "Occupied"
        }
        
        HabitatAPI.UserAPI().updateProperty(property: property, propId: UserDefaults.standard.integer(forKey: "selectedPropertyId"), completion: { property in
            possibleProperty = property
            if let updateProperty = possibleProperty {
                UserDefaults.standard.set("", forKey: "selectedPropertyId")
                UserDefaults.standard.set("", forKey: "selectedPropertyAddress")
                UserDefaults.standard.set("", forKey: "selectedPropertyDueDate")
                UserDefaults.standard.set("", forKey: "selectedPropertyStatus")
                UserDefaults.standard.set("", forKey: "selectedPropertyWorkerId")
                UserDefaults.standard.set("", forKey: "selectedPropertyLandlordId")
                self.performSegue(withIdentifier: "updatePropertyToPropertyList", sender: nil)
            } else {
                self.present(AlertViews().errorAlert(msg: "Could not update information."), animated: true)
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PropertyUpdateViewController {
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
