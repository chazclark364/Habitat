//
//  YelpBuisness.swift
//  Habitat
//
//  Created by Chaz Clark on 11/30/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation

class YelpBusiness: NSObject  {
    var name: String?
    var rating: Double?
    var phoneNumber: String?
    var address: String?
    var distance: Double?
    
    func requestFromJSON(json: NSDictionary?) -> YelpBusiness? {
        let buisness = YelpBusiness()
        buisness.name = json?.object(forKey: "name") as? String ?? "Unknown"
        buisness.rating = json?.object(forKey: "rating") as? Double ?? 0.0
        buisness.phoneNumber = json?.object(forKey: "display_phone") as? String ?? "Unknown"
        buisness.distance = json?.object(forKey: "distance") as? Double ?? 0.0
        if let location = (json as AnyObject).object(forKey: "location") as? NSDictionary {
            buisness.address = location.object(forKey: "city") as? String
                    
            
        }
        if(buisness.address == nil) {
            buisness.address = "Unknown"
        }
        
        
        return buisness
    }
}
