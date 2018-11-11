//
//  Tenant.swift
//  Habitat
//
//  Created by Travis Stanger on 11/5/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation

//This is a Habitat Tenant Object. Set properties of the Tenant in this class
class Tenant: NSObject  {
    var tenantId: Int?
    var landlordId: Int?
    var residence: String?
    var monthlyRent: Int?

    func tenantFromJSON(json: NSDictionary) -> Tenant? {
        let tenant = Tenant()
        tenant.tenantId = json.object(forKey: "idTenant") as? Int
        tenant.landlordId = json.object(forKey: "landlord") as? Int
        tenant.residence = json.object(forKey: "residence") as? String
        tenant.monthlyRent = json.object(forKey: "monthlyRent") as? Int
        return tenant
    }
}
