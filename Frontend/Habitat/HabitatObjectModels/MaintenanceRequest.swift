//
//  MaintenanceRequest.swift
//  Habitat
//
//  Created by Chaz Clark on 9/30/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation

class MaintenanceRequest: NSObject  {
    var requestId: Int?
    var title: String?
    var requestDescription: String?
    var dateRequested: Date?
    var requestee: Int?
    var landlord: Int?
    var worker: Int?
    //TODO: Change database to Int
    var status: String?
 
    //TODO: Create request function
    func requestFromJSON(json: NSDictionary) -> MaintenanceRequest? {
        let request = MaintenanceRequest()
        request.requestId = json.object(forKey: "requestId") as? Int
        request.title = json.object(forKey: "title") as? String
        request.requestDescription = json.object(forKey: "description") as? String
        request.requestee = json.object(forKey: "requestee") as? Int
        request.landlord = json.object(forKey: "landlord") as? Int
        request.status = json.object(forKey: "status") as? String
        return request
    }
    
}
