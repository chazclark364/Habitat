//
//  Property.swift
//  Habitat
//
//  Created by Travis Stanger on 12/2/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation

//This is a Habitat Property Object. Set properties of the Property in this class
class Property: NSObject  {
    var propertyId: Int?
    var landlordId: Int?
    var livingStatus: String?
    var address: String?
    var workerId: Int?
    var rentDueDate: String?
    
    func propertyFromJSON(json: NSDictionary) -> Property? {
        let property = Property()
        property.propertyId = json.object(forKey: "idProperty") as? Int
        property.landlordId = json.object(forKey: "landlord") as? Int
        property.livingStatus = json.object(forKey: "livingStatus") as? String
        property.address = json.object(forKey: "address") as? String
        property.workerId = json.object(forKey: "worker") as? Int
        property.rentDueDate = json.object(forKey: "rentDueDate") as? String
        return property
    }
}
