//
//  Landlord.swift
//  Habitat
//
//  Created by Travis Stanger on 11/5/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation

//This is a Habitat Landlord Object. Set properties of the Landlord in this class
class Landlord: NSObject  {
    var landlordId: Int?
    var address: String?
    
    func landlordFromJSON(json: NSDictionary) -> Landlord? {
        let landlord = Landlord()
        landlord.landlordId = json.object(forKey: "idLandlord") as? Int
        landlord.address = json.object(forKey: "address") as? String
        return landlord
    }
}
