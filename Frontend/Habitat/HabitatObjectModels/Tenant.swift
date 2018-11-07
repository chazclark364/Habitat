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
        return tenant
    }
}
