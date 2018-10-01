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
    var requestee: String?
    var landlord: String?
    var worker: String?
    //TODO: Change database to Int
    var status: Int?
    //    var password: String?
    
    //TODO: Create request function
}
